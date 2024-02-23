import 'dart:convert';

import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../movie/test/json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
      backdropPath: '/backdrop_path.jpg',
      firstAirDate: '2024-02-05',
      genreIds: [1, 2, 3],
      id: 1,
      name: 'Name',
      originalLanguage: 'id',
      originalName: 'Original Name',
      overview: 'Overview',
      popularity: 1.0,
      posterPath: '/poster_path.jpg',
      voteAverage: 1.0,
      voteCount: 1);
  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '/backdrop_path.jpg',
            'first_air_date': '2024-02-05',
            'genre_ids': [1, 2, 3],
            'id': 1,
            'name': 'Name',
            'original_language': 'id',
            'original_name': 'Original Name',
            'overview': 'Overview',
            'popularity': 1.0,
            'posterPath': '/poster_path.jpg',
            'vote_average': 1.0,
            'vote_count': 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
