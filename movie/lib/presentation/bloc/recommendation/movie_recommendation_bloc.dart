import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

import 'movie_recommendation_event.dart';
import 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc(this.getMovieRecommendations)
      : super(const MovieRecommendationEmpty()) {
    on<MovieRecommendationEvent>((event, emit) async {
      emit(MovieRecommendationLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(MovieRecommendationError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const MovieRecommendationEmpty("No Data"));
          } else {
            emit(MovieRecommendationHasData(data));
          }
        },
      );
    });
  }
}
