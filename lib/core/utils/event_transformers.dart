import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

/// Debounces events then processes only the latest (search-as-you-type).
EventTransformer<E> debounceRestartable<E>([
  Duration d = const Duration(milliseconds: 300),
]) =>
    (events, mapper) => restartable<E>().call(events.debounce(d), mapper);
