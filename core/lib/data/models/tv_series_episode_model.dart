import 'package:core/domain/entities/tv_series_episode.dart';
import 'package:equatable/equatable.dart';

class TvSeriesEpisodeModel extends Equatable {
  const TvSeriesEpisodeModel(
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

  factory TvSeriesEpisodeModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesEpisodeModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        runtime: json["runtime"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "runtime": runtime,
        "still_path": stillPath,
      };

  TvSeriesEpisode toEntity() {
    return TvSeriesEpisode(
      airDate: airDate,
      episodeNumber: episodeNumber,
      id: id,
      name: name,
      overview: overview,
      runtime: runtime,
      stillPath: stillPath,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        runtime,
        stillPath,
      ];
}
