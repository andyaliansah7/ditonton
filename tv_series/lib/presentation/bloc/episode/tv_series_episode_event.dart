import 'package:equatable/equatable.dart';

class TvSeriesEpisodeEvent extends Equatable {
  final int id;
  final int seasonNumber;

  const TvSeriesEpisodeEvent(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}
