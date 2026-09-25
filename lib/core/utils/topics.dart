import 'package:flutter/painting.dart';

import '../theme/app_colors.dart';

const _topicIndex = {
  'Anxiety': 0,
  'Stress': 1,
  'Sleep': 2,
  'Mindfulness': 3,
  'Growth': 3,
  'Relationships': 4,
  'Gratitude': 3,
  'Calm': 0,
  'Therapy': 4,
  'Self-care': 1,
};

/// Muted colour for a content/journal topic tag.
Color topicColor(MnColors c, String topic) {
  final i = _topicIndex[topic];
  return i == null ? MnColors.moss500 : c.topics[i];
}
