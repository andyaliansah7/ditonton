import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchMovieEvent extends Equatable {
  final String query;

  const SearchMovieEvent(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounceMovie<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
