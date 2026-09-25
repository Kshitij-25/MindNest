/// A professional's weekly bookable start times, keyed by ISO weekday
/// (`'1'` = Monday) with `HH:mm` values — stored on `therapists/{uid}.hours`.
typedef WorkingHours = Map<String, List<String>>;

const _weekdaySlots = ['09:00', '10:00', '11:30', '13:00', '14:30', '16:00', '17:30'];

/// Used until a professional configures their own hours.
const WorkingHours defaultWorkingHours = {
  '1': _weekdaySlots,
  '2': _weekdaySlots,
  '3': _weekdaySlots,
  '4': _weekdaySlots,
  '5': _weekdaySlots,
};

WorkingHours readWorkingHours(Object? v) {
  if (v is! Map || v.isEmpty) return defaultWorkingHours;
  return {
    for (final e in v.entries)
      '${e.key}': e.value is List ? [for (final t in e.value as List) '$t'] : const <String>[],
  };
}

/// Start times on [day] (date part only is used).
List<DateTime> slotsOn(WorkingHours hours, DateTime day) => [
      for (final t in hours['${day.weekday}'] ?? const <String>[])
        if (t.split(':') case [final h, final m])
          DateTime(day.year, day.month, day.day, int.parse(h), int.parse(m)),
    ];

/// "Today", "Tomorrow" or a short weekday for the next day with open hours.
String nextAvailableLabel(WorkingHours hours, {bool accepting = true}) {
  if (!accepting) return 'Waitlist';
  const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final now = DateTime.now();
  for (var d = 0; d < 8; d++) {
    final day = DateTime(now.year, now.month, now.day + d);
    if (slotsOn(hours, day).any((s) => s.isAfter(now))) {
      return d == 0 ? 'Today' : d == 1 ? 'Tomorrow' : names[day.weekday - 1];
    }
  }
  return '—';
}
