import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';

import '../../domain/entities/professional.dart';
import '../../domain/repositories/professional_repository.dart';
import '../datasource/professional_local_data_source.dart';
import '../mappers/professional_mappers.dart';

@LazySingleton(as: ProfessionalRepository)
class ProfessionalRepositoryImpl implements ProfessionalRepository {
  ProfessionalRepositoryImpl(this._local);
  final ProfessionalLocalDataSource _local;

  @override
  Future<Result<DashboardStats>> getDashboardStats() async {
    try {
      return Ok((await _local.getDashboardStats()).toEntity());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<BookingRequest>>> getRequests() async {
    try {
      final models = await _local.getRequests();
      return Ok(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<ProSession>>> getTodaySessions() async {
    try {
      final models = await _local.getTodaySessions();
      return Ok(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<ProClient>>> getClients() async {
    try {
      final models = await _local.getClients();
      return Ok(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<ProPost>>> getProPosts() async {
    try {
      final models = await _local.getProPosts();
      return Ok(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<ProPost>> getProPost(String id) async {
    try {
      return Ok((await _local.getProPost(id)).toEntity());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }
}
