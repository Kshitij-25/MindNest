import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/session.dart';
import '../../domain/entities/post.dart';
import '../models/post_model.dart';

abstract interface class FeedDataSource {
  Future<List<PostModel>> posts();
  Future<List<PostModel>> myPosts();
  Future<PostModel> post(String id);
  Future<void> setLiked(String id, bool liked);
  Future<void> setSaved(String id, bool saved);
  Future<List<CommentModel>> comments(String postId);
  Future<CommentModel> addComment(String postId, String author, String text);
  Future<void> setCommentLiked(String postId, String commentId, bool liked);
  Future<PostModel> create(PostModel model);
}

/// Posts live in `posts/`. Like/comment counters are kept with atomic
/// increments that security rules tie to the per-user marker docs
/// (`users/{uid}/likedPosts/{postId}`), so they can't drift or be forged.
@LazySingleton(as: FeedDataSource)
class FirestoreFeedDataSource implements FeedDataSource {
  FirestoreFeedDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  String get _me => _session.uid;
  CollectionReference<Map<String, dynamic>> get _liked => _db.userCol(_me, 'likedPosts');
  CollectionReference<Map<String, dynamic>> get _saved => _db.userCol(_me, 'savedPosts');

  Future<(Set<String>, Set<String>)> _marks() async {
    final r = await Future.wait([_liked.get(), _saved.get()]);
    return (r[0].docs.map((d) => d.id).toSet(), r[1].docs.map((d) => d.id).toSet());
  }

  PostModel _post(DocumentSnapshot<Map<String, dynamic>> s, (Set<String>, Set<String>) marks) {
    final d = s.data()!;
    final a = d['author'] as Map? ?? const {};
    return PostModel(
      id: s.id,
      author: PostAuthorModel(
        id: d['authorId'] as String? ?? '',
        name: a['name'] as String? ?? '',
        title: a['title'] as String? ?? '',
        spec: a['spec'] as String? ?? '',
        verified: a['verified'] as bool? ?? false,
      ),
      topic: d['topic'] as String? ?? '',
      title: d['title'] as String? ?? '',
      body: d['body'] as String? ?? '',
      publishedAt: readDate(d['publishedAt']),
      image: d['image'] as bool? ?? false,
      read: readInt(d['read'], 3),
      likes: readInt(d['likes']),
      comments: readInt(d['comments']),
      views: readInt(d['views']),
      liked: marks.$1.contains(s.id),
      saved: marks.$2.contains(s.id),
      status: d['status'] == 'draft' ? PostStatus.draft : PostStatus.published,
    );
  }

  @override
  Future<List<PostModel>> posts() async {
    final marks = await _marks();
    final snap = await _db.posts
        .where('status', isEqualTo: 'published')
        .orderBy('publishedAt', descending: true)
        .limit(50)
        .get();
    return snap.docs.map((d) => _post(d, marks)).toList();
  }

  @override
  Future<List<PostModel>> myPosts() async {
    final marks = await _marks();
    final snap = await _db.posts.where('authorId', isEqualTo: _me).orderBy('publishedAt', descending: true).get();
    return snap.docs.map((d) => _post(d, marks)).toList();
  }

  @override
  Future<PostModel> post(String id) async {
    final snap = await _db.posts.doc(id).get();
    if (!snap.exists) throw const NotFoundException();
    if (snap.data()!['authorId'] != _me) {
      snap.reference.update({'views': FieldValue.increment(1)}).ignore();
    }
    return _post(snap, await _marks());
  }

  @override
  Future<void> setLiked(String id, bool liked) async {
    final mark = _liked.doc(id);
    if ((await mark.get()).exists == liked) return;
    final batch = _db.batch()..update(_db.posts.doc(id), {'likes': FieldValue.increment(liked ? 1 : -1)});
    liked ? batch.set(mark, {'at': FieldValue.serverTimestamp()}) : batch.delete(mark);
    await batch.commit();
  }

  @override
  Future<void> setSaved(String id, bool saved) =>
      saved ? _saved.doc(id).set({'at': FieldValue.serverTimestamp()}) : _saved.doc(id).delete();

  CommentModel _comment(DocumentSnapshot<Map<String, dynamic>> s) {
    final d = s.data()!;
    final likedBy = readStrings(d['likedBy']);
    return CommentModel(
      id: s.id,
      name: d['name'] as String? ?? '',
      createdAt: readDate(d['createdAt']),
      text: d['text'] as String? ?? '',
      likes: likedBy.length,
      liked: likedBy.contains(_me),
    );
  }

  @override
  Future<List<CommentModel>> comments(String postId) async {
    final snap = await _db.posts.doc(postId).collection('comments').orderBy('createdAt').limitToLast(200).get();
    return snap.docs.map(_comment).toList();
  }

  @override
  Future<CommentModel> addComment(String postId, String author, String text) async {
    final postRef = _db.posts.doc(postId);
    final ref = postRef.collection('comments').doc();
    final batch = _db.batch()
      ..set(ref, {
        'authorId': _me,
        'name': author,
        'text': text,
        'likedBy': <String>[],
        'createdAt': FieldValue.serverTimestamp(),
      })
      ..update(postRef, {'comments': FieldValue.increment(1)});
    await batch.commit();
    return CommentModel(id: ref.id, name: author, createdAt: DateTime.now(), text: text);
  }

  @override
  Future<void> setCommentLiked(String postId, String commentId, bool liked) =>
      _db.posts.doc(postId).collection('comments').doc(commentId).update({
        'likedBy': liked ? FieldValue.arrayUnion([_me]) : FieldValue.arrayRemove([_me]),
      });

  @override
  Future<PostModel> create(PostModel m) async {
    final pro = (await _db.therapist(_me).get()).data() ?? const {};
    final author = PostAuthorModel(
      id: _me,
      name: pro['name'] as String? ?? '',
      title: pro['title'] as String? ?? 'Therapist',
      spec: pro['spec'] as String? ?? '',
      verified: pro['verified'] as bool? ?? false,
    );
    final words = m.body.trim().split(RegExp(r'\s+')).length;
    final read = (words / 200).ceil().clamp(1, 60);
    final ref = await _db.posts.add({
      'authorId': _me,
      'author': {'name': author.name, 'title': author.title, 'spec': author.spec, 'verified': author.verified},
      'topic': m.topic,
      'title': m.title,
      'body': m.body,
      'image': m.image,
      'read': read,
      'likes': 0,
      'comments': 0,
      'views': 0,
      'status': m.status.name,
      'publishedAt': FieldValue.serverTimestamp(),
    });
    return PostModel(
      id: ref.id,
      author: author,
      topic: m.topic,
      title: m.title,
      body: m.body,
      publishedAt: DateTime.now(),
      image: m.image,
      read: read,
      status: m.status,
    );
  }
}
