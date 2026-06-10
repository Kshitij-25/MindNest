import 'package:mindnest_app/core/error/result.dart';

import '../entities/professional.dart';

abstract interface class ProfessionalRepository {
  Future<Result<DashboardStats>> getDashboardStats();
  Future<Result<List<BookingRequest>>> getRequests();
  Future<Result<List<ProSession>>> getTodaySessions();
  Future<Result<List<ProClient>>> getClients();
  Future<Result<List<ProPost>>> getProPosts();
  Future<Result<ProPost>> getProPost(String id);
}
