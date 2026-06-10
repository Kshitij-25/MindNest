import 'package:freezed_annotation/freezed_annotation.dart';

part 'messaging_models.freezed.dart';
part 'messaging_models.g.dart';

@freezed
abstract class ConversationModel with _$ConversationModel {
  const factory ConversationModel({
    required String id,
    required String name,
    required String last,
    required String time,
    @Default(0) int unread,
    @Default(false) bool online,
    @Default(false) bool typing,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);
}

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required bool fromMe,
    required String text,
    required String time,
    @Default(false) bool read,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
