import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';
import 'package:watchlist/presentation/bloc/movie/watchlist_movie_event.dart';
import 'package:watchlist/presentation/bloc/movie/watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchlistStatusMovie;
  final SaveWatchlist _saveWatchlistMovie;
  final RemoveWatchlist _removeWatchlistMovie;

  WatchlistMovieBloc(this._getWatchlistMovies, this._getWatchlistStatusMovie,
      this._saveWatchlistMovie, this._removeWatchlistMovie)
      : super(const WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const WatchlistMovieEmpty("No Data"));
          } else {
            emit(WatchlistMovieHasData(data));
          }
        },
      );
    });

    on<LoadWatchlistMovieStatus>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _getWatchlistStatusMovie.execute(event.id);
      emit(WatchlistMovieStatus(result));
    });

    on<AddWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _saveWatchlistMovie.execute(event.movieDetail);

      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (success) async {
          emit(WatchlistMovieMessage(success));
        },
      );
    });

    on<DeleteWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await _removeWatchlistMovie.execute(event.movieDetail);
      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (success) => emit(WatchlistMovieMessage(success)),
      );
    });
  }
}
