import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieEmpty extends SearchMovieState {
  final String message;

  const SearchMovieEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final String message;

  const SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMovieHasData extends SearchMovieState {
  final List<Movie> result;

  const SearchMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
