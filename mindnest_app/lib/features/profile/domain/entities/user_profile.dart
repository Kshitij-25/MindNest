import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.email,
    required this.checkIns,
    required this.entries,
    required this.streak,
    required this.weekActivity,
    required this.moodWeek,
  });

  final String name, email, checkIns, entries, streak;
  final List<({String icon, String value, String label, String colorKey})>
  weekActivity;
  final List<int> moodWeek;

  @override
  List<Object?> get props => [
    name,
    email,
    checkIns,
    entries,
    streak,
    weekActivity,
    moodWeek,
  ];
}
