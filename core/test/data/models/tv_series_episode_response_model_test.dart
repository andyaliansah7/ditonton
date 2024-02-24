import 'dart:convert';

import 'package:core/data/models/tv_series_episode_model.dart';
import 'package:core/data/models/tv_series_episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesEpisodeModel = TvSeriesEpisodeModel(
    airDate: "2004-01-12",
    episodeNumber: 1,
    id: 1130462,
    name: "Bond of Love and Youth",
    overview: "",
    runtime: 60,
    stillPath: "/96Cwc5ejUAiH6iAA6xOp96dkSZS.jpg",
  );
  const tTvSeriesEpisodeResponseModel = TvSeriesEpisodeResponse(
      tvSeriesEpisodeList: <TvSeriesEpisodeModel>[tTvSeriesEpisodeModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_episodes.json'));
      // act
      final result = TvSeriesEpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesEpisodeResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesEpisodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'air_date': '2004-01-12',
            'episode_number': 1,
            'id': 1130462,
            'name': 'Bond of Love and Youth',
            'overview': '',
            'runtime': 60,
            'still_path': '/96Cwc5ejUAiH6iAA6xOp96dkSZS.jpg'
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
