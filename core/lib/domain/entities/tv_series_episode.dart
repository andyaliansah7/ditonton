import 'package:equatable/equatable.dart';

class TvSeriesEpisode extends Equatable {
  const TvSeriesEpisode(
      {required this.airDate,
      required this.episodeNumber,
      required this.id,
      required this.name,
      required this.overview,
      required this.runtime,
      required this.stillPath});

  final String? airDate;
  final int? episodeNumber;
  final int id;
  final String? name;
  final String? overview;
  final int? runtime;
  final String? stillPath;

  @override
  List<Object?> get props =>
      [airDate, episodeNumber, id, name, overview, runtime, stillPath];
}
