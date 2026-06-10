import 'package:injectable/injectable.dart';

import '../models/profile_models.dart';

@lazySingleton
class ProfileLocalDataSource {
  Future<ProfileModel> getProfile() async => ProfileModel.fromJson(_profile);

  static const _profile = <String, dynamic>{
    'name': 'Maya Levine',
    'email': 'maya.levine@email.com',
    'checkIns': '24',
    'entries': '18',
    'streak': '12',
    'weekActivity': <Map<String, dynamic>>[
      {'icon': 'heart', 'value': '6', 'label': 'Check-ins', 'colorKey': 'clay'},
      {
        'icon': 'feather',
        'value': '4',
        'label': 'Journal entries',
        'colorKey': 'topic4',
      },
      {
        'icon': 'calendar',
        'value': '1',
        'label': 'Session',
        'colorKey': 'primary',
      },
      {'icon': 'layers', 'value': '9', 'label': 'Reads', 'colorKey': 'topic1'},
    ],
    'moodWeek': <int>[3, 4, 2, 4, 5, 4, 4],
  };
}
