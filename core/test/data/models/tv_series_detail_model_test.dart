import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genres: List<GenreModel>.empty(),
      id: 1,
      name: 'name',
      originalName: 'originalName',
      overview: 'overview',
      posterPath: 'posterPath',
      voteAverage: 1.0,
      voteCount: 1,
      seasons: List<SeasonModel>.empty());

  final Map<String, dynamic> tTvSeriesDetailModelJson = {
    "adult": false,
    "backdrop_path": 'backdropPath',
    "first_air_date": 'firstAirDate',
    "genres": List<GenreModel>.empty(),
    "id": 1,
    "name": 'name',
    "original_name": 'originalName',
    "overview": 'overview',
    "poster_path": 'posterPath',
    "vote_average": 1.0,
    "vote_count": 1,
    "seasons": List<SeasonModel>.empty()
  };

  test('toJson should return a valid Map', () async {
    final result = tTvSeriesDetailModel.toJson();
    expect(result, tTvSeriesDetailModelJson);
  });
}
