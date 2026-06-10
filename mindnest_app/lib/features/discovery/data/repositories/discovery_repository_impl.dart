import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/entities/therapist.dart';
import '../../domain/repositories/discovery_repository.dart';
import '../datasource/discovery_local_data_source.dart';
import '../mappers/discovery_mappers.dart';

@LazySingleton(as: DiscoveryRepository)
class DiscoveryRepositoryImpl implements DiscoveryRepository {
  DiscoveryRepositoryImpl(this._local);
  final DiscoveryLocalDataSource _local;

  @override
  Future<Result<List<Therapist>>> getTherapists() async {
    try {
      final models = await _local.getTherapists();
      return Ok(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Therapist>> getTherapist(String id) async {
    try {
      final model = await _local.getTherapist(id);
      return Ok(model.toEntity());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<Therapist>>> getRecommended() async {
    try {
      final models = await _local.getTherapists();
      return Ok(models.take(3).map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<Review>>> getReviews(String therapistId) async {
    try {
      final models = await _local.getReviews();
      return Ok(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Appointment?>> getUpcomingAppointment() async {
    try {
      final model = await _local.getUpcomingAppointment();
      return Ok(model.toEntity());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<Unit>> submitBooking(BookingDraft draft) async {
    try {
      // Would POST to the bookings API; succeeds locally.
      return const Ok(unit);
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }
}
