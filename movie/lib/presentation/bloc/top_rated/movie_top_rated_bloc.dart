import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

import 'movie_top_rated_event.dart';
import 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies)
      : super(const MovieTopRatedEmpty()) {
    on<MovieTopRatedEvent>((event, emit) async {
      emit(MovieTopRatedLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(MovieTopRatedError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const MovieTopRatedEmpty("No Data"));
          } else {
            emit(MovieTopRatedHasData(data));
          }
        },
      );
    });
  }
}
