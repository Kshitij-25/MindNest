import 'package:injectable/injectable.dart';

import '../models/journal_models.dart';

@lazySingleton
class JournalLocalDataSource {
  Future<List<JournalEntryModel>> getEntries() async =>
      _entries.map(JournalEntryModel.fromJson).toList();

  Future<JournalEntryModel> getEntry(String id) async {
    final json = _entries.firstWhere(
      (e) => e['id'] == id,
      orElse: () => _entries.first,
    );
    return JournalEntryModel.fromJson(json);
  }

  static const _entries = <Map<String, dynamic>>[
    {
      'id': 'j1',
      'day': 'Today',
      'date': '31 May',
      'time': '8:24 AM',
      'mood': 4,
      'title': 'A slower morning',
      'body':
          'Woke up before the alarm and let myself lie still for a few minutes. The light through the curtains felt soft. I noticed I wasn’t reaching for my phone straight away — small win.',
      'tags': ['Calm', 'Gratitude'],
      'draft': false,
    },
    {
      'id': 'j2',
      'day': 'Yesterday',
      'date': '30 May',
      'time': '9:10 PM',
      'mood': 5,
      'title': 'Session reflections',
      'body':
          'Talked through the work stuff with Dr. Okafor. She reframed the “I’m behind” feeling as “I’m carrying a lot” and it landed. Trying to hold that gentler version of the story.',
      'tags': ['Therapy', 'Growth'],
      'draft': false,
    },
    {
      'id': 'j3',
      'day': 'Thu',
      'date': '29 May',
      'time': '7:02 AM',
      'mood': 3,
      'title': '',
      'body': 'Couldn’t sleep again. Mind kept looping on the',
      'tags': ['Sleep'],
      'draft': true,
    },
    {
      'id': 'j4',
      'day': 'Wed',
      'date': '28 May',
      'time': '6:40 PM',
      'mood': 2,
      'title': 'Heavy day',
      'body':
          'Deadlines piled up and I snapped at no one in particular. Naming it here so it doesn’t sit in my chest overnight.',
      'tags': ['Stress'],
      'draft': false,
    },
    {
      'id': 'j5',
      'day': 'Mon',
      'date': '26 May',
      'time': '8:00 AM',
      'mood': 4,
      'title': 'Morning walk',
      'body':
          'Twenty minutes by the canal before work. The cold air helped. Keep choosing this.',
      'tags': ['Self-care', 'Calm'],
      'draft': false,
    },
  ];
}
