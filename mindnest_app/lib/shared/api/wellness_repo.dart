import 'package:mindnest_app/core/network/wellness_api.dart';
import 'package:mindnest_app/shared/sample/wellness_sample.dart';

/// Fetches from [wellnessApi] and maps the backend JSON onto the wellness
/// model types so the widgets render live data. **Backend only** — no sample
/// fallback. List methods return an empty list (a valid empty state); single
/// payloads throw on a missing core field so `Loaded` shows its error state.
class WellnessRepo {
  const WellnessRepo();

  // ── helpers ────────────────────────────────────────────────────────
  static int _i(Object? v, [int d = 0]) =>
      v is num ? v.round() : (int.tryParse('$v') ?? d);
  static String _s(Object? v, [String d = '']) => v is String ? v : d;
  static List<Map<String, dynamic>> _list(Object? v) =>
      (v as List?)?.cast<Map<String, dynamic>>() ?? const [];

  // ── emotional profile ──────────────────────────────────────────────
  static const _dimColor = {
    'stress': 'topic-2',
    'anxiety': 'topic-1',
    'burnout': 'streak',
    'motivation': 'topic-4',
    'happiness': 'mood-4',
    'sadness': 'topic-5',
    'fatigue': 'topic-3',
    'loneliness': 'topic-5',
    'anger': 'clay',
    'instability': 'primary',
    'stability': 'primary',
  };

  String _dimensionColor(String dimension, int index) {
    final key = dimension.toLowerCase();
    for (final e in _dimColor.entries) {
      if (key.contains(e.key)) return e.value;
    }
    const fallback = ['topic-1', 'topic-2', 'topic-3', 'topic-4', 'topic-5'];
    return fallback[index % fallback.length];
  }

  List<Emotion> _emotionsFrom(List<Map<String, dynamic>> dims) => [
    for (final (i, d) in dims.indexed)
      Emotion(
        _s(d['label'], _s(d['dimension'], 'Dimension')),
        _i(d['score']),
        0,
        _dimensionColor(_s(d['dimension']), i),
        (d['elevated'] == true) ? 'Notable signal' : 'Within range',
      ),
  ];

  /// 8–10 dimension emotional profile (`/profile/mood-summary`).
  Future<List<Emotion>> emotionalProfile() async =>
      _emotionsFrom(_list((await wellnessApi.profileMoodSummary())['dimensions']));

  // ── wellness score ─────────────────────────────────────────────────
  Future<WellnessData> wellnessScore() async {
    final d = await wellnessApi.wellnessScore();
    if (d.isEmpty || d['score'] == null) throw StateError('no score');
    return WellnessData(
      score: _i(d['score']),
      trend: _s(d['trend'], 'flat'),
      weeklyChange: _i(d['weeklyChange']),
      confidence: _i(d['confidence']),
      band: _s(d['band'], 'Balanced'),
      signals: [
        for (final s in _list(d['signals']))
          WellnessSignal(
            _s(s['key'], 'Signal'),
            _i(s['value']),
            _s(s['weight'], 'Med'),
            _s(s['icon'], 'smile'),
          ),
      ],
      spark: (d['spark'] as List?)?.cast<int>() ?? const [],
    );
  }

  // ── insight detail (burnout) ───────────────────────────────────────
  Future<InsightDetail> insightDetail(String type) async {
    final d = await wellnessApi.insightDetail(type);
    if (d.isEmpty || d['metric'] == null) throw StateError('no detail');
    return InsightDetail(
      title: _s(d['title'], 'Insight'),
      kind: _s(d['kind'], 'Report'),
      icon: _s(d['icon'], 'flame'),
      color: _s(d['colorKey'], 'streak'),
      headline: _s(d['headline']),
      confidence: _i(d['confidence']),
      band: _s(d['band']),
      metric: _i(d['metric']),
      metricLabel: _s(d['metricLabel'], 'Index'),
      metricDelta: _i(d['metricDelta']),
      spark: (d['spark'] as List?)?.cast<int>() ?? const [],
      factors: [
        for (final f in _list(d['factors']))
          InsightFactor(_s(f['label']), _i(f['value']), _s(f['colorKey'], 'topic-2')),
      ],
      recs: (d['recIds'] as List?)?.cast<String>() ?? const [],
      context: _s(d['context']),
    );
  }

  // ── weekly report ──────────────────────────────────────────────────
  static String _fmtDate(String iso) {
    final p = iso.split('-');
    if (p.length != 3) return iso;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final m = int.tryParse(p[1]) ?? 1;
    final d = int.tryParse(p[2]) ?? 1;
    return '$d ${months[(m - 1).clamp(0, 11)]}';
  }

  Future<WeeklyReport> weeklyReportData() async {
    final d = await wellnessApi.weeklyReport();
    if (d.isEmpty || d['mood'] == null) throw StateError('no report');
    final mood = (d['mood'] as Map?)?.cast<String, dynamic>() ?? const {};
    final range = (d['range'] as Map?)?.cast<String, dynamic>() ?? const {};
    final ft = (d['followThrough'] as Map?)?.cast<String, dynamic>() ?? const {};
    final ftTotal = _i(ft['accepted']) + _i(ft['completed']) + _i(ft['dismissed']);
    final followPct = ftTotal > 0
        ? (((_i(ft['accepted']) + _i(ft['completed'])) / ftTotal) * 100).round()
        : 0;
    final start = _s(range['start']);
    final end = _s(range['end']);
    return WeeklyReport(
      range: (start.isEmpty || end.isEmpty)
          ? 'This week'
          : '${_fmtDate(start)} – ${_fmtDate(end)}',
      moodAvg: _s(mood['avgLabel'], 'Steady'),
      moodAvgLevel: mood['avgLevel'] is num ? (mood['avgLevel'] as num).round() : 3,
      moodChange: _s(mood['change']),
      best: _s(mood['bestDay']),
      hardest: _s(mood['hardestDay']),
      habitAdherence: (((d['habitAdherence'] as num?) ?? 0) * 100).round(),
      recFollowThrough: followPct,
      burnoutMovement: _i(d['burnoutMovement']),
      suggestedFocus: _s(d['suggestedFocus'], 'Consistency'),
      emotionalChanges: [
        for (final e in _list(d['emotionalChanges']))
          ReportDelta(_s(e['key'], 'Signal'), _i(e['delta'])),
      ],
      topTopics: [
        for (final t in _list(d['topTopics']))
          TopTopic(_s(t['topic'], 'Topic'), _i(t['count'])),
      ],
      patternsList: [for (final p in _list(d['patterns'])) _s(p['title'])],
      growthAreas: (d['growthAreas'] as List?)?.cast<String>() ?? const [],
    );
  }

  // ── recommendations ────────────────────────────────────────────────
  static const _recMeta = {
    'journal_prompt': ('feather', 'primary', '3 min'),
    'reflection': ('feather', 'primary', '3 min'),
    'breathing': ('wind', 'topic-1', '5 min'),
    'sleep': ('sleep', 'topic-3', 'Tonight'),
    'habit': ('repeat', 'topic-4', '10 min'),
    'mindfulness': ('brain', 'moss-500', '1 min'),
    'gratitude': ('heart', 'clay', '2 min'),
  };

  Rec _recFrom(Map<String, dynamic> r) {
    final kind = _s(r['kind'], 'reflection');
    final (icon, color, duration) =
        _recMeta[kind] ?? ('sparkle', 'primary', '5 min');
    final pretty = kind
        .split('_')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
    return Rec(
      id: _s(r['id']),
      kind: pretty,
      icon: icon,
      color: color,
      title: _s(r['title']),
      reason: _s(r['reason']),
      benefit: _s(r['body']),
      duration: duration,
      insight: _s(r['reason']),
    );
  }

  Future<List<Rec>> recommendations() async =>
      (await wellnessApi.recommendations()).map(_recFrom).toList();

  /// One recommendation by id (looked up in the active list).
  Future<Rec> recommendation(String id) async {
    final list = await recommendations();
    return list.firstWhere(
      (r) => r.id == id,
      orElse: () => throw StateError('recommendation not found'),
    );
  }

  // ── patterns ───────────────────────────────────────────────────────
  Future<List<Pattern>> patterns() async {
    final cards = _list((await wellnessApi.patterns())['patterns']);
    return [
      for (final (i, p) in cards.indexed)
        Pattern(
          'pt$i',
          _s(p['kind']) == 'behavior' ? 'repeat' : 'pulse',
          _s(p['colorKey'], 'topic-2'),
          _s(p['title']),
          _s(p['body']),
          _i(p['value']),
          _i(p['value']) >= 80 ? 'Strong' : 'Moderate',
        ),
    ];
  }

  // ── emotional timeline ─────────────────────────────────────────────
  Future<List<TimelineEvent>> timeline() async {
    final changes = _list((await wellnessApi.emotionalTimeline())['changes']);
    return [
      for (final (i, ch) in changes.indexed)
        TimelineEvent(
          'tl$i',
          _s(ch['label'], 'Recent'),
          () {
            final drift = (ch['drift'] as num?)?.round() ?? 0;
            return '${_s(ch['label'])} ${drift >= 0 ? '+' : ''}$drift%';
          }(),
          switch (_s(ch['direction'])) {
            'rising' => 'up',
            'falling' => 'down',
            _ => 'flat',
          },
          (ch['improving'] == true) ? 'good' : 'warn',
          (ch['drivers'] as List?)?.cast<String>() ?? const [],
          _s(ch['note']),
        ),
    ];
  }

  // ── assessments ────────────────────────────────────────────────────
  // icon · color · cadence by template id (presentation only).
  static const _assessMeta = {
    'daily': ('smile', 'mood-4', 'Every day'),
    'weekly': ('bookOpen', 'primary', 'Sundays'),
    'burnout': ('flame', 'streak', 'Adaptive'),
    'motivation': ('zap', 'topic-4', 'Adaptive'),
    'anxiety': ('wind', 'topic-1', 'Adaptive'),
  };

  Future<List<Assessment>> assessments() async {
    final raw = await wellnessApi.assessmentTemplates();
    return [
      for (final t in raw)
        () {
          final id = _s(t['id']);
          final (icon, color, freq) =
              _assessMeta[id] ?? ('sparkle', 'primary', 'Adaptive');
          return Assessment(
            id: id,
            name: _s(t['name'], id),
            sub: _s(t['description']),
            icon: icon,
            freq: freq,
            last: '',
            confidence: 0,
            items: _i(t['maxQuestions'], 6),
            done: false,
            color: color,
          );
        }(),
    ];
  }

  Future<List<AssessmentHistory>> assessmentHistory() async {
    final raw = await wellnessApi.assessmentHistory();
    return [
      for (final h in raw)
        AssessmentHistory(
          _s(h['template'], 'Assessment'),
          _s(h['createdAt']).split('T').first,
          _s(h['overallMood'], 'Steady'),
          ((h['confidence'] as num?) ?? 0.8) <= 1
              ? (((h['confidence'] as num?) ?? 0.8) * 100).round()
              : _i(h['confidence']),
          () {
            final v = (h['valence'] as num?) ?? 0;
            return v > 2 ? 'up' : (v < -2 ? 'down' : 'flat');
          }(),
        ),
    ];
  }

  // ── habits (list + per-habit analytics) ────────────────────────────
  static const _habitMeta = {
    'meditation': ('brain', 'moss-500'),
    'exercise': ('repeat', 'topic-4'),
    'sleep': ('sleep', 'topic-3'),
    'hydration': ('droplet', 'topic-1'),
    'reading': ('bookOpen', 'primary'),
  };

  Future<Habit> _habitFrom(Map<String, dynamic> h) async {
    final id = _s(h['id']);
    final kind = _s(h['kind'], 'custom');
    final (icon, color) = _habitMeta[kind] ?? ('target', 'primary');
    var streak = 0;
    var completion = 0;
    var correlation = 'Tracking how this shapes your mood';
    try {
      final a = await wellnessApi.habitAnalytics(id);
      completion = (((a['completionRate'] as num?) ?? 0) * 100).round();
      streak = _i(a['currentStreak']);
      final corr = a['correlation'] as Map?;
      if (corr != null && corr['insight'] is String) {
        correlation = corr['insight'] as String;
      }
    } catch (_) {}
    return Habit(
      id: id,
      name: _s(h['name'], kind),
      icon: icon,
      color: color,
      streak: streak,
      completion: completion,
      week: List.filled(7, h['doneToday'] == true),
      correlation: correlation,
    );
  }

  Future<List<Habit>> habits() async {
    final raw = await wellnessApi.habits();
    return Future.wait(raw.map(_habitFrom));
  }

  // ── memory highlights ──────────────────────────────────────────────
  static const _memMeta = {
    'journal': ('bookOpen', 'primary'),
    'assessment': ('sparkle', 'topic-4'),
    'insight': ('pulse', 'topic-2'),
  };

  Future<List<MemoryHighlight>> memory() async {
    final hits = _list(
      (await wellnessApi.memorySearch('reflection growth mood'))['results'],
    );
    return [
      for (final (i, m) in hits.indexed)
        () {
          final kind = _s(m['kind'], 'journal');
          final (icon, color) = _memMeta[kind] ?? ('bookOpen', 'primary');
          return MemoryHighlight(
            'm$i',
            '${kind[0].toUpperCase()}${kind.substring(1)} memory',
            icon,
            color,
            _s(m['summary'], 'A moment worth keeping'),
            _s(m['createdAt']).split('T').first,
            _s(m['snippet'], _s(m['summary'])),
          );
        }(),
    ];
  }

  // ── home dashboard ─────────────────────────────────────────────────
  /// Maps a 1–5 check-in level, falling back to a level derived from valence
  /// (clamped −100..100 server-side) when there's no recent check-in.
  static int _moodLevel(Object? level, Object? valence) {
    if (level is num) return level.round().clamp(1, 5);
    final v = valence is num ? valence.toDouble() : 0.0;
    return (((v + 100) / 200 * 4) + 1).round().clamp(1, 5);
  }

  Future<DashboardData> dashboard() async {
    final d = await wellnessApi.dashboard();
    if (d.isEmpty) throw StateError('no dashboard');
    final profile = d['emotionalProfile'] as Map<String, dynamic>?;
    final recsRaw = _list(d['recommendations']);
    final insight = d['latestInsight'] as Map<String, dynamic>?;
    final mood = (d['currentMood'] as Map?)?.cast<String, dynamic>() ?? const {};
    final streak = (d['streak'] as Map?)?.cast<String, dynamic>() ?? const {};
    return DashboardData(
      displayName: (d['displayName'] is String) ? d['displayName'] as String : null,
      moodLabel: _s(mood['label'], 'How are you feeling?'),
      moodLevel: _moodLevel(mood['level'], mood['valence']),
      hasCheckin: mood['level'] is num,
      streakCurrent: _i(streak['current']),
      streakGoal: _i(streak['goal'], 7),
      emotions: _emotionsFrom(_list(profile?['dimensions'])),
      recommendation: recsRaw.isEmpty ? null : _recFrom(recsRaw.first),
      latestInsight: insight == null
          ? null
          : _s(insight['headline'], _s(insight['body'])),
      weeklyTrend: (d['weeklyTrend'] as List?)?.cast<int>() ?? const [],
    );
  }
}

/// Bundle for the home dashboard insights row (nullable where the backend may
/// have nothing yet).
class DashboardData {
  const DashboardData({
    this.displayName,
    required this.moodLabel,
    required this.moodLevel,
    required this.hasCheckin,
    required this.streakCurrent,
    required this.streakGoal,
    required this.emotions,
    this.recommendation,
    this.latestInsight,
    required this.weeklyTrend,
  });
  final String? displayName;
  final String moodLabel;
  final int moodLevel;
  final bool hasCheckin;
  final int streakCurrent;
  final int streakGoal;
  final List<Emotion> emotions;
  final Rec? recommendation;
  final String? latestInsight;
  final List<int> weeklyTrend;
}

/// Shared instance.
const wellnessRepo = WellnessRepo();
