import 'package:injectable/injectable.dart';

import '../../../../core/network/mock_latency.dart';
import '../models/mood_entry_model.dart';

abstract interface class MoodDataSource {
  Future<List<MoodEntryModel>> entries();
  Future<List<int>> dailyLevels(int days);
  Future<MoodEntryModel> log({required int level, required List<String> factors, required String note});
}

/// In-memory mock API. State lives for the app session.
@LazySingleton(as: MoodDataSource)
class MoodMockDataSource implements MoodDataSource {
  MoodMockDataSource() {
    final now = DateTime.now();
    _entries.addAll([
      MoodEntryModel.fromJson({
        'id': 'm1',
        'level': 4,
        'createdAt': DateTime(now.year, now.month, now.day, 9, 24).toIso8601String(),
        'factors': ['Sleep', 'Exercise'],
        'note': 'Slept well and had a calm morning walk.',
      }),
      MoodEntryModel.fromJson({
        'id': 'm2',
        'level': 5,
        'createdAt': DateTime(now.year, now.month, now.day - 1, 20, 10).toIso8601String(),
        'factors': ['Therapy'],
        'note': 'Great session with Dr. Okafor.',
      }),
      MoodEntryModel.fromJson({
        'id': 'm3',
        'level': 2,
        'createdAt': DateTime(now.year, now.month, now.day - 3, 7, 45).toIso8601String(),
        'factors': ['Work'],
        'note': 'Deadline stress got to me.',
      }),
    ]);
  }

  final _entries = <MoodEntryModel>[];

  // 28 days of history, oldest first; the final 7 match the prototype's week.
  final _levels = <int>[3, 4, 4, 3, 2, 4, 5, 4, 3, 4, 4, 5, 5, 4, 3, 2, 3, 4, 5, 4, 4, 3, 4, 2, 4, 5, 4, 4];

  @override
  Future<List<MoodEntryModel>> entries() async {
    await mockLatency();
    return List.of(_entries)..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<int>> dailyLevels(int days) async {
    await mockLatency(150);
    return _levels.sublist(_levels.length - days);
  }

  @override
  Future<MoodEntryModel> log({required int level, required List<String> factors, required String note}) async {
    await mockLatency(500);
    final m = MoodEntryModel(
      id: 'm${DateTime.now().microsecondsSinceEpoch}',
      level: level,
      createdAt: DateTime.now(),
      factors: factors,
      note: note,
    );
    _entries.insert(0, m);
    _levels[_levels.length - 1] = level;
    return m;
  }
}
