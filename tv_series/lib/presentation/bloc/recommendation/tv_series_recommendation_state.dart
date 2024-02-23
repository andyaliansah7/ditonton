import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationEmpty extends TvSeriesRecommendationState {
  final String message;

  const TvSeriesRecommendationEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {}

class TvSeriesRecommendationHasData extends TvSeriesRecommendationState {
  final List<TvSeries> tvSeries;

  const TvSeriesRecommendationHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;

  const TvSeriesRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}
