import 'package:injectable/injectable.dart';

import '../models/professional_models.dart';

/// Local (seeded) data source standing in for the professional-side API.
@lazySingleton
class ProfessionalLocalDataSource {
  Future<DashboardStatsModel> getDashboardStats() async =>
      DashboardStatsModel.fromJson(_stats);

  Future<List<BookingRequestModel>> getRequests() async =>
      _requests.map(BookingRequestModel.fromJson).toList();

  Future<List<ProSessionModel>> getTodaySessions() async =>
      _sessions.map(ProSessionModel.fromJson).toList();

  Future<List<ProClientModel>> getClients() async =>
      _clients.map(ProClientModel.fromJson).toList();

  Future<List<ProPostModel>> getProPosts() async =>
      _posts.map(ProPostModel.fromJson).toList();

  Future<ProPostModel> getProPost(String id) async {
    final json = _posts.firstWhere(
      (p) => p['id'] == id,
      orElse: () => _posts.first,
    );
    return ProPostModel.fromJson(json);
  }

  static const _stats = <String, dynamic>{
    'sessionsToday': '3',
    'newRequests': '2',
    'rating': '4.9',
    'weekEarnings': '£1,240',
  };

  static const _requests = <Map<String, dynamic>>[
    {
      'id': 'q1',
      'name': 'Jordan Mills',
      'when': 'Fri 6 Jun · 2:00 PM',
      'reason': 'Anxiety & work stress',
      'status': 'Pending',
      'mins': 50,
    },
    {
      'id': 'q2',
      'name': 'Priya Shah',
      'when': 'Sat 7 Jun · 11:00 AM',
      'reason': 'First consultation',
      'status': 'Pending',
      'mins': 30,
    },
  ];

  static const _sessions = <Map<String, dynamic>>[
    {
      'id': 's1',
      'name': 'Leah Karim',
      'when': 'Today · 1:00 PM',
      'type': 'Video',
      'mins': 50,
      'status': 'Accepted',
    },
    {
      'id': 's2',
      'name': 'Sam Rivera',
      'when': 'Today · 3:30 PM',
      'type': 'Chat',
      'mins': 50,
      'status': 'Accepted',
    },
    {
      'id': 's3',
      'name': 'Noah Bennett',
      'when': 'Tomorrow · 10:00 AM',
      'type': 'Video',
      'mins': 50,
      'status': 'Accepted',
    },
  ];

  static const _posts = <Map<String, dynamic>>[
    {
      'id': 'pp1',
      'topic': 'Anxiety',
      'time': '2h',
      'status': 'Published',
      'image': true,
      'likes': 128,
      'comments': 18,
      'views': 1240,
      'title': 'The 3-3-3 rule for an anxious mind',
    },
    {
      'id': 'pp2',
      'topic': 'Mindfulness',
      'time': '3d',
      'status': 'Published',
      'image': true,
      'likes': 211,
      'comments': 31,
      'views': 2890,
      'title': 'A 60-second reset for busy days',
    },
    {
      'id': 'pp3',
      'topic': 'Stress',
      'time': '—',
      'status': 'Draft',
      'image': false,
      'likes': 0,
      'comments': 0,
      'views': 0,
      'title': 'Untangling the “I’m behind” feeling',
    },
  ];

  static const _clients = <Map<String, dynamic>>[
    {
      'id': 'c1',
      'name': 'Jordan Mills',
      'last': 'Thank you, that really helped today.',
      'time': '9:24',
      'unread': 1,
      'online': true,
    },
    {
      'id': 'c2',
      'name': 'Leah Karim',
      'last': 'See you Thursday!',
      'time': 'Yesterday',
      'unread': 0,
      'online': false,
    },
    {
      'id': 'c3',
      'name': 'Sam Rivera',
      'last': 'I tried the breathing exercise.',
      'time': 'Mon',
      'unread': 0,
      'online': true,
    },
  ];
}
