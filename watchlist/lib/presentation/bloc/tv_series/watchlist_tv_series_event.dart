import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTvSeries extends WatchlistTvSeriesEvent {}

class LoadWatchlistTvSeriesStatus extends WatchlistTvSeriesEvent {
  final int id;

  const LoadWatchlistTvSeriesStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistTvSeries extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class DeleteWatchlistTvSeries extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvSeriesDetail;

  const DeleteWatchlistTvSeries(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
