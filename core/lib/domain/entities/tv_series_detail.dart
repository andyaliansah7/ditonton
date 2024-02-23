import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail(
      {required this.adult,
      required this.backdropPath,
      required this.genres,
      required this.id,
      required this.name,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.firstAirDate,
      required this.voteAverage,
      required this.voteCount,
      required this.seasons});

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        name,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        voteAverage,
        voteCount,
        seasons
      ];
}
