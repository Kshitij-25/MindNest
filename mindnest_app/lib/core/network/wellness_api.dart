import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/network/dio_client.dart';

/// Thin typed client over the MindNest wellness API (`/api/v1/*`). Methods
/// return decoded JSON (the backend emits camelCase for these routes and uses
/// no response envelope, so `response.data` is the model directly).
///
/// Kept as a plain object (resolved lazily through [getIt] for [DioClient]) so
/// new endpoints can be wired without regenerating the injectable graph.
class WellnessApi {
  const WellnessApi();

  DioClient get _dio => getIt<DioClient>();

  // ── Dashboard / reads ──────────────────────────────────────────────
  Future<Map<String, dynamic>> dashboard() async =>
      (await _dio.get<Map<String, dynamic>>('/dashboard')).data ?? const {};

  Future<List<Map<String, dynamic>>> recommendations() async {
    final res = await _dio.get<List<dynamic>>('/recommendations');
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> insights(String scope) async =>
      (await _dio.get<Map<String, dynamic>>('/insights/$scope')).data ??
      const {};

  Future<List<Map<String, dynamic>>> habits() async {
    final res = await _dio.get<List<dynamic>>('/habits');
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> habitAnalytics(String id) async =>
      (await _dio.get<Map<String, dynamic>>('/habits/$id/analytics')).data ??
      const {};

  Future<Map<String, dynamic>> weeklyReport() async =>
      (await _dio.get<Map<String, dynamic>>('/reports/weekly')).data ??
      const {};

  Future<Map<String, dynamic>> wellnessScore() async =>
      (await _dio.get<Map<String, dynamic>>('/insights/wellness-score')).data ??
      const {};

  Future<Map<String, dynamic>> insightDetail(String type) async =>
      (await _dio.get<Map<String, dynamic>>('/insights/detail/$type')).data ??
      const {};

  Future<List<Map<String, dynamic>>> library() async {
    final res = await _dio.get<List<dynamic>>('/library');
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> libraryArticle(String id) async =>
      (await _dio.get<Map<String, dynamic>>('/library/$id')).data ?? const {};

  Future<Map<String, dynamic>> emotionalTimeline({int days = 30}) async =>
      (await _dio.get<Map<String, dynamic>>(
        '/analytics/emotional-timeline',
        query: {'days': days},
      )).data ??
      const {};

  Future<Map<String, dynamic>> patterns() async =>
      (await _dio.get<Map<String, dynamic>>('/analytics/patterns')).data ??
      const {};

  Future<Map<String, dynamic>> memorySearch(String query) async =>
      (await _dio.get<Map<String, dynamic>>(
        '/memory/search',
        query: {'q': query},
      )).data ??
      const {};

  Future<List<Map<String, dynamic>>> assessmentTemplates() async {
    final res = await _dio.get<List<dynamic>>('/assessment/templates');
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> assessmentHistory() async {
    final res = await _dio.get<List<dynamic>>('/assessment/history');
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> journalEntries({
    bool includeDrafts = true,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      '/journal/entries',
      query: {'include_drafts': includeDrafts},
    );
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> journalEntry(String id) async =>
      (await _dio.get<Map<String, dynamic>>('/journal/entries/$id')).data ??
      const {};

  Future<Map<String, dynamic>> journalAnalysis(String id) async =>
      (await _dio.get<Map<String, dynamic>>(
        '/journal/entries/$id/analysis',
      )).data ??
      const {};

  Future<List<Map<String, dynamic>>> notifications() async {
    final res = await _dio.get<List<dynamic>>('/notifications');
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> moodHistory() async =>
      (await _dio.get<Map<String, dynamic>>('/mood/history')).data ?? const {};

  Future<Map<String, dynamic>> moodInsights() async =>
      (await _dio.get<Map<String, dynamic>>('/mood/insights')).data ?? const {};

  Future<Map<String, dynamic>> accountProfile() async =>
      (await _dio.get<Map<String, dynamic>>('/profile')).data ?? const {};

  /// Legacy 10-dimension snapshot (`/profile/mood-summary`, snake_case JSON).
  Future<Map<String, dynamic>> profileMoodSummary() async =>
      (await _dio.get<Map<String, dynamic>>('/profile/mood-summary')).data ??
      const {};

  Future<Map<String, dynamic>> settings() async =>
      (await _dio.get<Map<String, dynamic>>('/settings')).data ?? const {};

  Future<Map<String, dynamic>> flagCatalog() async =>
      (await _dio.get<Map<String, dynamic>>('/settings/flags')).data ?? const {};

  Future<void> updateSettings({
    Map<String, bool>? featureFlags,
    String? theme,
  }) => _dio.patch<Map<String, dynamic>>(
    '/settings',
    data: {
      'featureFlags': ?featureFlags,
      'theme': ?theme,
    },
  );

  Future<List<Map<String, dynamic>>> coachHistory(String conversationId) async {
    final res = await _dio.get<List<dynamic>>(
      '/coach/history',
      query: {'conversation_id': conversationId},
    );
    return (res.data ?? const []).cast<Map<String, dynamic>>();
  }

  // ── Writes / interactions ──────────────────────────────────────────
  Future<({String reply, String conversationId})> coachChat(
    String message, {
    String? conversationId,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/coach/chat',
      data: {
        'message': message,
        'conversationId': ?conversationId,
      },
    );
    final d = res.data ?? const {};
    return (
      reply: (d['reply'] as String?) ?? '',
      conversationId: (d['conversationId'] as String?) ?? '',
    );
  }

  Future<Map<String, dynamic>> createJournal({
    String kind = 'free',
    required String title,
    required String body,
    int mood = 3,
    List<String> tags = const [],
    bool draft = false,
  }) async =>
      (await _dio.post<Map<String, dynamic>>(
        '/journal/entries',
        data: {
          'kind': kind,
          'title': title,
          'body': body,
          'mood': mood,
          'tags': tags,
          'draft': draft,
        },
      )).data ??
      const {};

  Future<void> recommendationFeedback(String id, String action) =>
      _dio.post<Map<String, dynamic>>(
        '/recommendations/$id/feedback',
        data: {'action': action},
      );

  Future<void> moodCheckin({
    required int level,
    List<String> factors = const [],
    String? note,
  }) => _dio.post<Map<String, dynamic>>(
    '/mood/checkin',
    data: {
      'level': level,
      'factors': factors,
      if (note != null && note.isNotEmpty) 'note': note,
    },
  );
}

/// Shared instance for screens that aren't backed by a cubit yet.
const wellnessApi = WellnessApi();
