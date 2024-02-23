import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends WatchlistMovieEvent {}

class LoadWatchlistMovieStatus extends WatchlistMovieEvent {
  final int id;

  const LoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class DeleteWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const DeleteWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
