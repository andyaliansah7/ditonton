import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class TvSeriesTopRatedEmpty extends TvSeriesTopRatedState {
  final String message;

  const TvSeriesTopRatedEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class TvSeriesTopRatedLoading extends TvSeriesTopRatedState {}

class TvSeriesTopRatedHasData extends TvSeriesTopRatedState {
  final List<TvSeries> tvSeries;

  const TvSeriesTopRatedHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesTopRatedError extends TvSeriesTopRatedState {
  final String message;

  const TvSeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
