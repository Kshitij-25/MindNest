import '../../domain/entities/post.dart';
import '../models/feed_models.dart';

extension PostModelX on PostModel {
  Post toEntity() => Post(
    id: id,
    authorId: authorId,
    authorName: authorName,
    authorTitle: authorTitle,
    topic: topic,
    time: time,
    image: image,
    read: read,
    likes: likes,
    comments: comments,
    title: title,
    body: body,
    saved: saved,
    liked: liked,
  );
}

extension PostCommentModelX on PostCommentModel {
  PostComment toEntity() =>
      PostComment(id: id, name: name, time: time, text: text, likes: likes);
}
