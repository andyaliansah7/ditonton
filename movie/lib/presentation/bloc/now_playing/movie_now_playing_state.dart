import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingEmpty extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> movies;

  const MovieNowPlayingHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
