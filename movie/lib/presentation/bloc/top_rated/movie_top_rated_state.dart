import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedEmpty extends MovieTopRatedState {
  final String message;

  const MovieTopRatedEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class MovieTopRatedLoading extends MovieTopRatedState {}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> movies;

  const MovieTopRatedHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
