import 'package:injectable/injectable.dart';

import '../models/feed_models.dart';

@lazySingleton
class FeedLocalDataSource {
  Future<List<PostModel>> getPosts() async =>
      _posts.map(PostModel.fromJson).toList();

  Future<PostModel> getPost(String id) async {
    final json = _posts.firstWhere(
      (p) => p['id'] == id,
      orElse: () => _posts.first,
    );
    return PostModel.fromJson(json);
  }

  Future<List<PostCommentModel>> getComments(String postId) async =>
      (_comments[postId] ?? _comments['p1']!)
          .map(PostCommentModel.fromJson)
          .toList();

  static const _posts = <Map<String, dynamic>>[
    {
      'id': 'p1',
      'authorId': 't1',
      'authorName': 'Dr. Amara Okafor',
      'authorTitle': 'Clinical Psychologist',
      'topic': 'Anxiety',
      'time': '2h',
      'image': true,
      'read': 4,
      'likes': 128,
      'comments': 18,
      'saved': false,
      'liked': false,
      'title': 'The 3-3-3 rule for an anxious mind',
      'body':
          'When anxiety spikes, try this gentle grounding tool. Name three things you can see, three sounds you can hear, and move three parts of your body. It won’t erase the feeling — but it gently reminds your nervous system that you’re here, and you’re safe.\n\nThe goal isn’t to force calm. It’s to give your attention somewhere kinder to land.',
    },
    {
      'id': 'p2',
      'authorId': 't3',
      'authorName': 'Dr. Priya Nair',
      'authorTitle': 'Counselling Psychologist',
      'topic': 'Sleep',
      'time': '5h',
      'image': false,
      'read': 3,
      'likes': 94,
      'comments': 12,
      'saved': true,
      'liked': true,
      'title': 'Why “trying harder” to sleep backfires',
      'body':
          'Sleep is a letting-go, not a doing. The more we chase it, the more alert we become. Tonight, instead of trying to sleep, try simply resting — no goal, no clock-watching. Rest is restorative on its own.',
    },
    {
      'id': 'p3',
      'authorId': 't2',
      'authorName': 'Daniel Mercer',
      'authorTitle': 'Psychotherapist',
      'topic': 'Mindfulness',
      'time': '1d',
      'image': true,
      'read': 5,
      'likes': 211,
      'comments': 31,
      'saved': false,
      'liked': false,
      'title': 'A 60-second reset for busy days',
      'body':
          'You don’t need an hour to come back to yourself. One slow breath, a hand on your chest, and a single kind sentence: “This is hard, and I’m doing my best.” Repeat as needed.',
    },
    {
      'id': 'p4',
      'authorId': 't4',
      'authorName': 'Sofia Almeida',
      'authorTitle': 'Therapist',
      'topic': 'Relationships',
      'time': '2d',
      'image': false,
      'read': 4,
      'likes': 76,
      'comments': 9,
      'saved': false,
      'liked': false,
      'title': 'Boundaries are a form of care',
      'body':
          'Saying no isn’t shutting someone out — it’s being honest about what you can hold. A clear boundary, kindly stated, protects the relationship as much as it protects you.',
    },
  ];

  static const _comments = <String, List<Map<String, dynamic>>>{
    'p1': [
      {
        'id': 'pc1',
        'name': 'Leah K.',
        'time': '1h',
        'text':
            'Needed this today. The “somewhere kinder to land” line really got me.',
        'likes': 12,
      },
      {
        'id': 'pc2',
        'name': 'Sam R.',
        'time': '40m',
        'text': 'Tried it on the train this morning and it genuinely helped.',
        'likes': 5,
      },
      {
        'id': 'pc3',
        'name': 'Maya L.',
        'time': '12m',
        'text': 'Saving this for my next anxious moment 💚',
        'likes': 2,
      },
    ],
  };
}
