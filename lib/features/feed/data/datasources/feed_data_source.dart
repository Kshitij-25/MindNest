import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/mock_latency.dart';
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

@LazySingleton(as: FeedDataSource)
class FeedMockDataSource implements FeedDataSource {
  FeedMockDataSource() {
    final now = DateTime.now();
    const okafor = PostAuthorModel(id: 't1', name: 'Dr. Amara Okafor', title: 'Clinical Psychologist', spec: 'Anxiety & Stress');
    const mercer = PostAuthorModel(id: 't2', name: 'Daniel Mercer', title: 'Psychotherapist', spec: 'Depression & Mood');
    const nair = PostAuthorModel(id: 't3', name: 'Dr. Priya Nair', title: 'Counselling Psychologist', spec: 'Sleep & Burnout');
    const almeida = PostAuthorModel(id: 't4', name: 'Sofia Almeida', title: 'Therapist', spec: 'Relationships');
    _posts.addAll([
      PostModel(
        id: 'p1',
        author: okafor,
        topic: 'Anxiety',
        publishedAt: now.subtract(const Duration(hours: 2)),
        image: true,
        read: 4,
        likes: 128,
        comments: 18,
        views: 1240,
        title: 'The 3-3-3 rule for an anxious mind',
        body:
            'When anxiety spikes, try this gentle grounding tool. Name three things you can see, three sounds you can hear, and move three parts of your body. It won’t erase the feeling — but it gently reminds your nervous system that you’re here, and you’re safe.\n\nThe goal isn’t to force calm. It’s to give your attention somewhere kinder to land.',
      ),
      PostModel(
        id: 'p2',
        author: nair,
        topic: 'Sleep',
        publishedAt: now.subtract(const Duration(hours: 5)),
        read: 3,
        likes: 94,
        comments: 12,
        saved: true,
        liked: true,
        title: 'Why “trying harder” to sleep backfires',
        body:
            'Sleep is a letting-go, not a doing. The more we chase it, the more alert we become. Tonight, instead of trying to sleep, try simply resting — no goal, no clock-watching. Rest is restorative on its own.',
      ),
      PostModel(
        id: 'p3',
        author: mercer,
        topic: 'Mindfulness',
        publishedAt: now.subtract(const Duration(days: 1)),
        image: true,
        read: 5,
        likes: 211,
        comments: 31,
        views: 2890,
        title: 'A 60-second reset for busy days',
        body:
            'You don’t need an hour to come back to yourself. One slow breath, a hand on your chest, and a single kind sentence: “This is hard, and I’m doing my best.” Repeat as needed.',
      ),
      PostModel(
        id: 'p4',
        author: almeida,
        topic: 'Relationships',
        publishedAt: now.subtract(const Duration(days: 2)),
        read: 4,
        likes: 76,
        comments: 9,
        title: 'Boundaries are a form of care',
        body:
            'Saying no isn’t shutting someone out — it’s being honest about what you can hold. A clear boundary, kindly stated, protects the relationship as much as it protects you.',
      ),
    ]);
    _mine.addAll([
      PostModel(
        id: 'pp1', author: _me, topic: 'Anxiety', publishedAt: now.subtract(const Duration(hours: 2)), image: true,
        likes: 128, comments: 18, views: 1240, title: 'The 3-3-3 rule for an anxious mind', body: _posts[0].body,
      ),
      PostModel(
        id: 'pp2', author: _me, topic: 'Mindfulness', publishedAt: now.subtract(const Duration(days: 3)), image: true,
        likes: 211, comments: 31, views: 2890, title: 'A 60-second reset for busy days', body: _posts[2].body,
      ),
      PostModel(
        id: 'pp3', author: _me, topic: 'Stress', publishedAt: now, status: PostStatus.draft,
        title: 'Untangling the “I’m behind” feeling', body: 'Draft…',
      ),
    ]);
    _comments['p1'] = [
      CommentModel(id: 'pc1', name: 'Leah K.', createdAt: now.subtract(const Duration(hours: 1)), text: 'Needed this today. The “somewhere kinder to land” line really got me.', likes: 12),
      CommentModel(id: 'pc2', name: 'Sam R.', createdAt: now.subtract(const Duration(minutes: 40)), text: 'Tried it on the train this morning and it genuinely helped.', likes: 5),
      CommentModel(id: 'pc3', name: 'Maya L.', createdAt: now.subtract(const Duration(minutes: 12)), text: 'Saving this for my next anxious moment 💚', likes: 2),
    ];
  }

  static const _me = PostAuthorModel(id: 'pro-1', name: 'Dr. Evelyn Hale', title: 'Clinical Psychologist', spec: 'Anxiety & Trauma');

  final _posts = <PostModel>[];
  final _mine = <PostModel>[];
  final _comments = <String, List<CommentModel>>{};

  PostModel _find(String id) =>
      [..._posts, ..._mine].firstWhere((p) => p.id == id, orElse: () => throw const NotFoundException());

  @override
  Future<List<PostModel>> posts() async {
    await mockLatency();
    return _posts;
  }

  @override
  Future<List<PostModel>> myPosts() async {
    await mockLatency();
    return _mine;
  }

  @override
  Future<PostModel> post(String id) async {
    await mockLatency(150);
    return _find(id);
  }

  @override
  Future<void> setLiked(String id, bool liked) async {
    final p = _find(id);
    if (p.liked != liked) p.likes += liked ? 1 : -1;
    p.liked = liked;
  }

  @override
  Future<void> setSaved(String id, bool saved) async => _find(id).saved = saved;

  @override
  Future<List<CommentModel>> comments(String postId) async {
    await mockLatency(250);
    return _comments.putIfAbsent(postId, () => List.of(_comments['p1'] ?? const []));
  }

  @override
  Future<CommentModel> addComment(String postId, String author, String text) async {
    await mockLatency(200);
    final c = CommentModel(id: 'c${DateTime.now().microsecondsSinceEpoch}', name: author, createdAt: DateTime.now(), text: text);
    _comments.putIfAbsent(postId, () => []).add(c);
    _find(postId).comments++;
    return c;
  }

  @override
  Future<void> setCommentLiked(String postId, String commentId, bool liked) async {
    final c = _comments[postId]?.firstWhere((x) => x.id == commentId);
    if (c == null) return;
    if (c.liked != liked) c.likes += liked ? 1 : -1;
    c.liked = liked;
  }

  @override
  Future<PostModel> create(PostModel model) async {
    await mockLatency(800);
    final m = PostModel(
      id: 'pp${DateTime.now().microsecondsSinceEpoch}',
      author: _me,
      topic: model.topic,
      title: model.title,
      body: model.body,
      publishedAt: DateTime.now(),
      image: model.image,
      status: model.status,
    );
    _mine.insert(0, m);
    return m;
  }
}
