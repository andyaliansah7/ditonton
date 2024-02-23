import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesHasData extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  const WatchlistTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvSeriesStatus extends WatchlistTvSeriesState {
  final bool status;

  const WatchlistTvSeriesStatus(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesMessage extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesMessage(this.message);

  @override
  List<Object> get props => [message];
}
