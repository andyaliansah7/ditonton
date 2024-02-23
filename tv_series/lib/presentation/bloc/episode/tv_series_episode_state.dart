import 'package:core/domain/entities/tv_series_episode.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesEpisodeState extends Equatable {
  const TvSeriesEpisodeState();

  @override
  List<Object> get props => [];
}

class TvSeriesEpisodeEmpty extends TvSeriesEpisodeState {
  final String message;

  const TvSeriesEpisodeEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class TvSeriesEpisodeLoading extends TvSeriesEpisodeState {}

class TvSeriesEpisodeHasData extends TvSeriesEpisodeState {
  final List<TvSeriesEpisode> tvSeriesEpisode;

  const TvSeriesEpisodeHasData(this.tvSeriesEpisode);

  @override
  List<Object> get props => [tvSeriesEpisode];
}

class TvSeriesEpisodeError extends TvSeriesEpisodeState {
  final String message;

  const TvSeriesEpisodeError(this.message);

  @override
  List<Object> get props => [message];
}
