import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series_episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_episodes.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesEpisodes usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesEpisodes(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeasonId = 1;
  final tTvSeriesEpisodes = <TvSeriesEpisode>[];

  test('should get list of tv series episodes from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesEpisodes(tId, tSeasonId))
        .thenAnswer((_) async => Right(tTvSeriesEpisodes));
    // act
    final result = await usecase.execute(tId, tSeasonId);
    // assert
    expect(result, Right(tTvSeriesEpisodes));
  });
}
