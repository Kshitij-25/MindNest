import 'package:injectable/injectable.dart';

import '../models/discovery_models.dart';

/// Local (seeded) data source standing in for a remote therapist API.
/// Returns models parsed from JSON to exercise the serialization path.
@lazySingleton
class DiscoveryLocalDataSource {
  Future<List<TherapistModel>> getTherapists() async =>
      _therapists.map(TherapistModel.fromJson).toList();

  Future<TherapistModel> getTherapist(String id) async {
    final json = _therapists.firstWhere(
      (t) => t['id'] == id,
      orElse: () => _therapists.first,
    );
    return TherapistModel.fromJson(json);
  }

  Future<List<ReviewModel>> getReviews() async =>
      _reviews.map(ReviewModel.fromJson).toList();

  Future<AppointmentModel> getUpcomingAppointment() async =>
      AppointmentModel.fromJson(_appointment);

  static const _therapists = <Map<String, dynamic>>[
    {
      'id': 't1',
      'name': 'Dr. Amara Okafor',
      'title': 'Clinical Psychologist',
      'spec': 'Anxiety & Stress',
      'tags': ['Anxiety', 'Stress', 'CBT'],
      'rating': 4.9,
      'reviews': 214,
      'years': 11,
      'verified': true,
      'price': 90,
      'location': 'Remote · London',
      'next': 'Tomorrow',
      'langs': ['English', 'Yoruba'],
      'about':
          'I help people untangle anxious thinking and rebuild a steadier relationship with everyday life. My approach is warm, structured, and paced to you.',
      'quals': [
        'PhD Clinical Psychology, UCL',
        'HCPC Registered',
        'Certified CBT Practitioner',
      ],
    },
    {
      'id': 't2',
      'name': 'Daniel Mercer',
      'title': 'Psychotherapist',
      'spec': 'Depression & Mood',
      'tags': ['Depression', 'Mood', 'Mindfulness'],
      'rating': 4.8,
      'reviews': 156,
      'years': 8,
      'verified': true,
      'price': 75,
      'location': 'Remote · Manchester',
      'next': 'Today',
      'langs': ['English'],
      'about':
          'A calm, non-judgemental space to work through low mood and find small footholds back toward the things that matter to you.',
      'quals': ['MSc Psychotherapy', 'BACP Accredited', 'Mindfulness-Based CT'],
    },
    {
      'id': 't3',
      'name': 'Dr. Priya Nair',
      'title': 'Counselling Psychologist',
      'spec': 'Sleep & Burnout',
      'tags': ['Sleep', 'Burnout', 'Work stress'],
      'rating': 5.0,
      'reviews': 98,
      'years': 13,
      'verified': true,
      'price': 110,
      'location': 'Remote · Edinburgh',
      'next': 'Thu',
      'langs': ['English', 'Hindi'],
      'about':
          'I work with high-functioning burnout and sleep difficulties, blending CBT-I with compassion-focused techniques.',
      'quals': [
        'DPsych Counselling Psychology',
        'HCPC Registered',
        'CBT-I Certified',
      ],
    },
    {
      'id': 't4',
      'name': 'Sofia Almeida',
      'title': 'Therapist',
      'spec': 'Relationships',
      'tags': ['Relationships', 'Self-esteem'],
      'rating': 4.7,
      'reviews': 132,
      'years': 6,
      'verified': true,
      'price': 70,
      'location': 'Remote · Lisbon',
      'next': 'Fri',
      'langs': ['English', 'Portuguese'],
      'about':
          'Relationship and self-worth work in a gentle, collaborative style. We move at a pace that feels safe for you.',
      'quals': ['MA Integrative Counselling', 'BACP Registered'],
    },
  ];

  static const _reviews = <Map<String, dynamic>>[
    {
      'id': 'r1',
      'name': 'Jordan M.',
      'rating': 5,
      'time': '2 weeks ago',
      'text':
          'Genuinely changed how I handle stressful weeks. I feel heard and never rushed.',
    },
    {
      'id': 'r2',
      'name': 'Leah K.',
      'rating': 5,
      'time': '1 month ago',
      'text':
          'Patient, warm, and practical. The tools we built actually stuck.',
    },
    {
      'id': 'r3',
      'name': 'Sam R.',
      'rating': 4,
      'time': '2 months ago',
      'text': 'A really safe space. Sessions always leave me a little lighter.',
    },
  ];

  static const _appointment = <String, dynamic>{
    'id': 'a1',
    'tid': 't1',
    'date': 'Thu, 5 Jun',
    'time': '4:00 PM',
    'type': 'Video session',
    'status': 'Accepted',
    'mins': 50,
  };
}
