import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/mock_latency.dart';
import '../models/therapist_model.dart';
import 'therapist_mock_data.dart';

abstract interface class TherapistDataSource {
  Future<List<TherapistModel>> therapists();
  Future<TherapistModel> therapist(String id);
  Future<List<ReviewModel>> reviews(String therapistId);
  Future<Set<String>> savedIds();
  Future<bool> toggleSaved(String id);
}

@LazySingleton(as: TherapistDataSource)
class TherapistMockDataSource implements TherapistDataSource {
  final _all = therapistsJson.map(TherapistModel.fromJson).toList();
  final _saved = <String>{};

  @override
  Future<List<TherapistModel>> therapists() async {
    await mockLatency();
    return _all;
  }

  @override
  Future<TherapistModel> therapist(String id) async {
    await mockLatency(200);
    return _all.firstWhere((t) => t.id == id, orElse: () => throw const NotFoundException());
  }

  @override
  Future<List<ReviewModel>> reviews(String therapistId) async {
    await mockLatency(250);
    return reviewsJson.map(ReviewModel.fromJson).toList();
  }

  @override
  Future<Set<String>> savedIds() async => _saved;

  @override
  Future<bool> toggleSaved(String id) async {
    await mockLatency(120);
    return _saved.contains(id) ? !_saved.remove(id) : _saved.add(id);
  }
}
