import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<MovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await _getMovieDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (dataDetail) {
          emit(MovieDetailHasData(dataDetail));
        },
      );
    });
  }
}
