import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object> get props => [];
}

class TvSeriesPopularEmpty extends TvSeriesPopularState {
  final String message;

  const TvSeriesPopularEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class TvSeriesPopularLoading extends TvSeriesPopularState {}

class TvSeriesPopularHasData extends TvSeriesPopularState {
  final List<TvSeries> tvSeries;

  const TvSeriesPopularHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;

  const TvSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}
