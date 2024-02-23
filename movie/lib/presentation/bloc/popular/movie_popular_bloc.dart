import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

import 'movie_popular_event.dart';
import 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getMoviePopulars;

  MoviePopularBloc(this._getMoviePopulars) : super(const MoviePopularEmpty()) {
    on<MoviePopularEvent>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await _getMoviePopulars.execute();
      result.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const MoviePopularEmpty("No Data"));
          } else {
            emit(MoviePopularHasData(data));
          }
        },
      );
    });
  }
}
