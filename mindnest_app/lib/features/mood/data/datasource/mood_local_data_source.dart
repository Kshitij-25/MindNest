import 'package:injectable/injectable.dart';

import '../models/mood_models.dart';

@lazySingleton
class MoodLocalDataSource {
  Future<List<int>> getWeek() async => const [3, 4, 2, 4, 5, 4, 4];

  Future<List<int>> getMonth() async => const [
    4,
    3,
    4,
    5,
    4,
    2,
    3,
    4,
    4,
    5,
    5,
    4,
    3,
    4,
    4,
    5,
    4,
    3,
    2,
    4,
    5,
    4,
    4,
    5,
    3,
    4,
    5,
    4,
  ];

  Future<List<int>> getInsightMonth() async => const [
    3,
    4,
    4,
    3,
    2,
    4,
    5,
    4,
    3,
    4,
    4,
    5,
    5,
    4,
    3,
    2,
    3,
    4,
    5,
    4,
    4,
    5,
    4,
    3,
    4,
    5,
    4,
    4,
  ];

  Future<List<MoodEntryModel>> getRecentEntries() async =>
      _recent.map(MoodEntryModel.fromJson).toList();

  static const _recent = <Map<String, dynamic>>[
    {
      'day': 'Today',
      'time': '9:24 AM',
      'level': 4,
      'note': 'Slept well and had a calm morning walk.',
      'factors': ['Sleep', 'Exercise'],
    },
    {
      'day': 'Yesterday',
      'time': '8:10 PM',
      'level': 5,
      'note': 'Great session with Dr. Okafor.',
      'factors': ['Therapy'],
    },
    {
      'day': 'Wed',
      'time': '7:45 AM',
      'level': 2,
      'note': 'Deadline stress got to me.',
      'factors': ['Work'],
    },
  ];
}
