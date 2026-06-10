import 'package:equatable/equatable.dart';

/// A pending or actioned booking request from a client.
class BookingRequest extends Equatable {
  const BookingRequest({
    required this.id,
    required this.name,
    required this.when,
    required this.reason,
    required this.status,
    required this.mins,
  });

  final String id, name, when, reason, status;
  final int mins;

  String get firstName => name.split(' ').first;

  @override
  List<Object?> get props => [id, status];
}

/// A confirmed (or otherwise) session on the professional's calendar.
class ProSession extends Equatable {
  const ProSession({
    required this.id,
    required this.name,
    required this.when,
    required this.type,
    required this.mins,
    required this.status,
  });

  final String id, name, when, type, status;
  final int mins;

  @override
  List<Object?> get props => [id];
}

/// A piece of content authored by the professional.
class ProPost extends Equatable {
  const ProPost({
    required this.id,
    required this.topic,
    required this.time,
    required this.status,
    required this.image,
    required this.likes,
    required this.comments,
    required this.views,
    required this.title,
  });

  final String id, topic, time, status, title;
  final bool image;
  final int likes, comments, views;

  @override
  List<Object?> get props => [id];
}

/// A client conversation summary shown on the professional's clients tab.
class ProClient extends Equatable {
  const ProClient({
    required this.id,
    required this.name,
    required this.last,
    required this.time,
    required this.unread,
    required this.online,
  });

  final String id, name, last, time;
  final int unread;
  final bool online;

  @override
  List<Object?> get props => [id];
}

/// Headline stats shown on the professional dashboard.
class DashboardStats extends Equatable {
  const DashboardStats({
    required this.sessionsToday,
    required this.newRequests,
    required this.rating,
    required this.weekEarnings,
  });

  final String sessionsToday, newRequests, rating, weekEarnings;

  @override
  List<Object?> get props => [sessionsToday, newRequests, rating, weekEarnings];
}
