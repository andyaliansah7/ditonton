import 'package:core/data/models/tv_series_episode_model.dart';
import 'package:core/domain/entities/tv_series_episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesEpisodeModel = TvSeriesEpisodeModel(
    airDate: "2004-01-12",
    episodeNumber: 1,
    id: 1130462,
    name: "Bond of Love and Youth",
    overview: "",
    runtime: 60,
    stillPath: null,
  );

  const tTvSeriesEpisode = TvSeriesEpisode(
    airDate: "2004-01-12",
    episodeNumber: 1,
    id: 1130462,
    name: "Bond of Love and Youth",
    overview: "",
    runtime: 60,
    stillPath: null,
  );

  test('should be a subclass of TV Series entity', () async {
    final result = tTvSeriesEpisodeModel.toEntity();
    expect(result, tTvSeriesEpisode);
  });
}
