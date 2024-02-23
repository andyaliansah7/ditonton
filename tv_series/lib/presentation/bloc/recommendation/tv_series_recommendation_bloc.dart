import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_event.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationBloc(this.getTvSeriesRecommendations)
      : super(const TvSeriesRecommendationEmpty()) {
    on<TvSeriesRecommendationEvent>((event, emit) async {
      emit(TvSeriesRecommendationLoading());
      final result = await getTvSeriesRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(TvSeriesRecommendationError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const TvSeriesRecommendationEmpty("No Data"));
          } else {
            emit(TvSeriesRecommendationHasData(data));
          }
        },
      );
    });
  }
}
