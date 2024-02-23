import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonModel = SeasonModel(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
      voteAverage: 1.0);

  const tSeason = Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
      voteAverage: 1.0);

  const Map<String, dynamic> tSeasonModelJson = {
    "air_date": 'airDate',
    "episode_count": 1,
    "id": 1,
    "name": 'name',
    "overview": 'overview',
    "poster_path": 'posterPath',
    "season_number": 1,
    "vote_average": 1.0,
  };

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });

  test('toJson should return a valid Map', () async {
    final result = tSeasonModel.toJson();
    expect(result, tSeasonModelJson);
  });

  test('props should return a list of all properties', () async {
    final props = tSeasonModel.props;

    expect(props.length, 8);

    expect(props.contains(tSeasonModel.airDate), true);
    expect(props.contains(tSeasonModel.episodeCount), true);
    expect(props.contains(tSeasonModel.id), true);
    expect(props.contains(tSeasonModel.name), true);
    expect(props.contains(tSeasonModel.overview), true);
    expect(props.contains(tSeasonModel.posterPath), true);
    expect(props.contains(tSeasonModel.seasonNumber), true);
    expect(props.contains(tSeasonModel.voteAverage), true);
  });
}
