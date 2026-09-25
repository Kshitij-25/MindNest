import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/mock_latency.dart';
import '../../domain/entities/appointment.dart';
import '../models/appointment_model.dart';

abstract interface class SessionsDataSource {
  Future<List<AppointmentModel>> appointments();
  Future<AppointmentModel> create(AppointmentModel model);
  Future<void> cancel(String id);
  Future<Map<DateTime, List<(DateTime, bool)>>> availability(String therapistId, DateTime from, int days);
}

@LazySingleton(as: SessionsDataSource)
class SessionsMockDataSource implements SessionsDataSource {
  SessionsMockDataSource() {
    final now = DateTime.now();
    DateTime at(int dayOffset, int hour) => DateTime(now.year, now.month, now.day + dayOffset, hour);
    _items.addAll([
      AppointmentModel(
        id: 'a1',
        therapistId: 't1',
        startsAt: at(5, 16),
        status: AppointmentStatus.accepted,
        recurrence: Recurrence.weekly,
      ),
      AppointmentModel(
        id: 'a2',
        therapistId: 't3',
        startsAt: at(12, 16),
        status: AppointmentStatus.accepted,
        recurrence: Recurrence.weekly,
      ),
      AppointmentModel(id: 'p1', therapistId: 't1', startsAt: at(-7, 16), status: AppointmentStatus.completed),
      AppointmentModel(id: 'p2', therapistId: 't1', startsAt: at(-14, 16), status: AppointmentStatus.completed),
    ]);
  }

  final _items = <AppointmentModel>[];

  @override
  Future<List<AppointmentModel>> appointments() async {
    await mockLatency();
    return List.of(_items);
  }

  @override
  Future<AppointmentModel> create(AppointmentModel model) async {
    await mockLatency(700);
    _items.add(model);
    return model;
  }

  @override
  Future<void> cancel(String id) async {
    await mockLatency(400);
    final i = _items.indexWhere((a) => a.id == id);
    if (i < 0) throw const NotFoundException();
    _items[i] = _items[i].copyWith(status: AppointmentStatus.cancelled);
  }

  @override
  Future<Map<DateTime, List<(DateTime, bool)>>> availability(String therapistId, DateTime from, int days) async {
    await mockLatency(250);
    const hours = [(9, 0), (10, 0), (11, 30), (13, 0), (14, 30), (16, 0), (17, 30)];
    final seed = therapistId.codeUnits.fold<int>(0, (a, b) => a + b);
    return {
      for (var d = 0; d < days; d++)
        DateTime(from.year, from.month, from.day + d): [
          // Weekends and one weekday per week are unavailable.
          if (!_off(DateTime(from.year, from.month, from.day + d), seed))
            for (final (i, (h, m)) in hours.indexed)
              (DateTime(from.year, from.month, from.day + d, h, m), (i + d + seed) % 5 == 2),
        ],
    };
  }

  bool _off(DateTime d, int seed) => d.weekday == DateTime.sunday || (d.weekday + seed) % 6 == 0;
}
