import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/professional.dart';
import '../repositories/professional_repository.dart';

@lazySingleton
class GetDashboardStats implements UseCase<DashboardStats, NoParams> {
  GetDashboardStats(this._repo);
  final ProfessionalRepository _repo;
  @override
  Future<Result<DashboardStats>> call(NoParams params) =>
      _repo.getDashboardStats();
}

@lazySingleton
class GetBookingRequests implements UseCase<List<BookingRequest>, NoParams> {
  GetBookingRequests(this._repo);
  final ProfessionalRepository _repo;
  @override
  Future<Result<List<BookingRequest>>> call(NoParams params) =>
      _repo.getRequests();
}

@lazySingleton
class GetTodaySessions implements UseCase<List<ProSession>, NoParams> {
  GetTodaySessions(this._repo);
  final ProfessionalRepository _repo;
  @override
  Future<Result<List<ProSession>>> call(NoParams params) =>
      _repo.getTodaySessions();
}

@lazySingleton
class GetProClients implements UseCase<List<ProClient>, NoParams> {
  GetProClients(this._repo);
  final ProfessionalRepository _repo;
  @override
  Future<Result<List<ProClient>>> call(NoParams params) => _repo.getClients();
}

@lazySingleton
class GetProPosts implements UseCase<List<ProPost>, NoParams> {
  GetProPosts(this._repo);
  final ProfessionalRepository _repo;
  @override
  Future<Result<List<ProPost>>> call(NoParams params) => _repo.getProPosts();
}

@lazySingleton
class GetProPost implements UseCase<ProPost, String> {
  GetProPost(this._repo);
  final ProfessionalRepository _repo;
  @override
  Future<Result<ProPost>> call(String id) => _repo.getProPost(id);
}
