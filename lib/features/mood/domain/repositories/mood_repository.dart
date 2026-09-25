import '../../../../core/usecase/usecase.dart';
import '../entities/mood_entry.dart';
import '../entities/mood_summary.dart';

abstract interface class MoodRepository {
  ResultFuture<MoodSummary> getSummary();
  ResultFuture<MoodEntry> logMood({required int level, required List<String> factors, required String note});
}
