import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesEmpty([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class SearchTvSeriesLoading extends SearchTvSeriesState {}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvSeriesHasData extends SearchTvSeriesState {
  final List<TvSeries> result;

  const SearchTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
