import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {
  final String message;

  const WatchlistMovieEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> result;

  const WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMovieStatus extends WatchlistMovieState {
  final bool status;

  const WatchlistMovieStatus(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieMessage extends WatchlistMovieState {
  final String message;

  const WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}
