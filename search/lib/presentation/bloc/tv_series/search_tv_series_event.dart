import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchTvSeriesEvent extends Equatable {
  final String query;

  const SearchTvSeriesEvent(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounceTvSeries<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
