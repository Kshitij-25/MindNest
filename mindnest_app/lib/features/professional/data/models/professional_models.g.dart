// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingRequestModel _$BookingRequestModelFromJson(Map<String, dynamic> json) =>
    _BookingRequestModel(
      id: json['id'] as String,
      name: json['name'] as String,
      when: json['when'] as String,
      reason: json['reason'] as String,
      status: json['status'] as String? ?? 'Pending',
      mins: (json['mins'] as num).toInt(),
    );

Map<String, dynamic> _$BookingRequestModelToJson(
  _BookingRequestModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'when': instance.when,
  'reason': instance.reason,
  'status': instance.status,
  'mins': instance.mins,
};

_ProSessionModel _$ProSessionModelFromJson(Map<String, dynamic> json) =>
    _ProSessionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      when: json['when'] as String,
      type: json['type'] as String,
      mins: (json['mins'] as num).toInt(),
      status: json['status'] as String? ?? 'Accepted',
    );

Map<String, dynamic> _$ProSessionModelToJson(_ProSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'when': instance.when,
      'type': instance.type,
      'mins': instance.mins,
      'status': instance.status,
    };

_ProPostModel _$ProPostModelFromJson(Map<String, dynamic> json) =>
    _ProPostModel(
      id: json['id'] as String,
      topic: json['topic'] as String,
      time: json['time'] as String,
      status: json['status'] as String? ?? 'Published',
      image: json['image'] as bool? ?? false,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as num?)?.toInt() ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ProPostModelToJson(_ProPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'time': instance.time,
      'status': instance.status,
      'image': instance.image,
      'likes': instance.likes,
      'comments': instance.comments,
      'views': instance.views,
      'title': instance.title,
    };

_ProClientModel _$ProClientModelFromJson(Map<String, dynamic> json) =>
    _ProClientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      last: json['last'] as String,
      time: json['time'] as String,
      unread: (json['unread'] as num?)?.toInt() ?? 0,
      online: json['online'] as bool? ?? false,
    );

Map<String, dynamic> _$ProClientModelToJson(_ProClientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last': instance.last,
      'time': instance.time,
      'unread': instance.unread,
      'online': instance.online,
    };

_DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) =>
    _DashboardStatsModel(
      sessionsToday: json['sessionsToday'] as String,
      newRequests: json['newRequests'] as String,
      rating: json['rating'] as String,
      weekEarnings: json['weekEarnings'] as String,
    );

Map<String, dynamic> _$DashboardStatsModelToJson(
  _DashboardStatsModel instance,
) => <String, dynamic>{
  'sessionsToday': instance.sessionsToday,
  'newRequests': instance.newRequests,
  'rating': instance.rating,
  'weekEarnings': instance.weekEarnings,
};
