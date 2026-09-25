import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/assessment.dart';

part 'assessment_model.g.dart';

@JsonSerializable()
class AssessmentModel {
  const AssessmentModel({required this.mood, required this.stress, this.anxiety, required this.sleep, required this.goals});

  factory AssessmentModel.fromJson(Map<String, dynamic> json) => _$AssessmentModelFromJson(json);

  factory AssessmentModel.fromEntity(Assessment a) =>
      AssessmentModel(mood: a.mood, stress: a.stress, anxiety: a.anxiety, sleep: a.sleep, goals: a.goals);

  final int mood;
  final int stress;
  final int? anxiety;
  final int sleep;
  final List<String> goals;

  Map<String, dynamic> toJson() => _$AssessmentModelToJson(this);

  Assessment toEntity() => Assessment(mood: mood, stress: stress, anxiety: anxiety, sleep: sleep, goals: goals);
}
