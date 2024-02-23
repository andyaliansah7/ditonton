import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

import 'movie_now_playing_event.dart';
import 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies)
      : super(const MovieNowPlayingEmpty()) {
    on<MovieNowPlayingEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(MovieNowPlayingError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const MovieNowPlayingEmpty("No Data"));
          } else {
            emit(MovieNowPlayingHasData(data));
          }
        },
      );
    });
  }
}
