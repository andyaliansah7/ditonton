import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesNowPlayingState extends Equatable {
  const TvSeriesNowPlayingState();

  @override
  List<Object> get props => [];
}

class TvSeriesNowPlayingEmpty extends TvSeriesNowPlayingState {
  final String message;

  const TvSeriesNowPlayingEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class TvSeriesNowPlayingLoading extends TvSeriesNowPlayingState {}

class TvSeriesNowPlayingHasData extends TvSeriesNowPlayingState {
  final List<TvSeries> tvSeries;

  const TvSeriesNowPlayingHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TvSeriesNowPlayingError extends TvSeriesNowPlayingState {
  final String message;

  const TvSeriesNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
