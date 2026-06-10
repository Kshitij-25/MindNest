import '../../domain/entities/professional.dart';
import '../models/professional_models.dart';

extension BookingRequestModelX on BookingRequestModel {
  BookingRequest toEntity() => BookingRequest(
    id: id,
    name: name,
    when: when,
    reason: reason,
    status: status,
    mins: mins,
  );
}

extension ProSessionModelX on ProSessionModel {
  ProSession toEntity() => ProSession(
    id: id,
    name: name,
    when: when,
    type: type,
    mins: mins,
    status: status,
  );
}

extension ProPostModelX on ProPostModel {
  ProPost toEntity() => ProPost(
    id: id,
    topic: topic,
    time: time,
    status: status,
    image: image,
    likes: likes,
    comments: comments,
    views: views,
    title: title,
  );
}

extension ProClientModelX on ProClientModel {
  ProClient toEntity() => ProClient(
    id: id,
    name: name,
    last: last,
    time: time,
    unread: unread,
    online: online,
  );
}

extension DashboardStatsModelX on DashboardStatsModel {
  DashboardStats toEntity() => DashboardStats(
    sessionsToday: sessionsToday,
    newRequests: newRequests,
    rating: rating,
    weekEarnings: weekEarnings,
  );
}
