import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularEmpty extends MoviePopularState {
  final String message;

  const MoviePopularEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class MoviePopularLoading extends MoviePopularState {}

class MoviePopularHasData extends MoviePopularState {
  final List<Movie> movies;

  const MoviePopularHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviePopularError extends MoviePopularState {
  final String message;

  const MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}
