import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/mock_latency.dart';
import '../models/journal_entry_model.dart';

abstract interface class JournalDataSource {
  Future<List<JournalEntryModel>> entries();
  Future<JournalEntryModel> upsert(JournalEntryModel model);
  Future<void> delete(String id);
}

@LazySingleton(as: JournalDataSource)
class JournalMockDataSource implements JournalDataSource {
  JournalMockDataSource() {
    final now = DateTime.now();
    DateTime at(int d, int h, int m) => DateTime(now.year, now.month, now.day - d, h, m);
    _items.addAll([
      JournalEntryModel(
        id: 'j1',
        createdAt: at(0, 8, 24),
        mood: 4,
        title: 'A slower morning',
        body:
            'Woke up before the alarm and let myself lie still for a few minutes. The light through the curtains felt soft. I noticed I wasn’t reaching for my phone straight away — small win.',
        tags: ['Calm', 'Gratitude'],
        favourite: true,
      ),
      JournalEntryModel(
        id: 'j2',
        createdAt: at(1, 21, 10),
        mood: 5,
        title: 'Session reflections',
        body:
            'Talked through the work stuff with Dr. Okafor. She reframed the “I’m behind” feeling as “I’m carrying a lot” and it landed. Trying to hold that gentler version of the story.',
        tags: ['Therapy', 'Growth'],
      ),
      JournalEntryModel(
        id: 'j3',
        createdAt: at(2, 7, 2),
        mood: 3,
        body: 'Couldn’t sleep again. Mind kept looping on the',
        tags: ['Sleep'],
        draft: true,
      ),
      JournalEntryModel(
        id: 'j4',
        createdAt: at(3, 18, 40),
        mood: 2,
        title: 'Heavy day',
        body: 'Deadlines piled up and I snapped at no one in particular. Naming it here so it doesn’t sit in my chest overnight.',
        tags: ['Stress'],
      ),
      JournalEntryModel(
        id: 'j5',
        createdAt: at(5, 8, 0),
        mood: 4,
        title: 'Morning walk',
        body: 'Twenty minutes by the canal before work. The cold air helped. Keep choosing this.',
        tags: ['Self-care', 'Calm'],
      ),
      for (final (d, m) in [(8, 3), (10, 4), (13, 5), (15, 2), (18, 4), (20, 3), (23, 4)])
        JournalEntryModel(
          id: 'jh$d',
          createdAt: at(d, 20, 0),
          mood: m,
          title: 'Evening note',
          body: 'A short check-in before bed.',
          tags: const ['Calm'],
        ),
    ]);
  }

  final _items = <JournalEntryModel>[];

  @override
  Future<List<JournalEntryModel>> entries() async {
    await mockLatency();
    return List.of(_items)..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<JournalEntryModel> upsert(JournalEntryModel model) async {
    await mockLatency(400);
    final i = _items.indexWhere((e) => e.id == model.id);
    i < 0 ? _items.add(model) : _items[i] = model;
    return model;
  }

  @override
  Future<void> delete(String id) async {
    await mockLatency(250);
    final before = _items.length;
    _items.removeWhere((e) => e.id == id);
    if (_items.length == before) throw const NotFoundException();
  }
}
