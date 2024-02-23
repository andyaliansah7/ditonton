import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series_episode.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_episodes.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_event.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_state.dart';

import 'tv_series_episode_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesEpisodes])
void main() {
  late TvSeriesEpisodeBloc tvSeriesEpisodeBloc;
  late MockGetTvSeriesEpisodes mockGetTvSeriesEpisodes;

  const id = 1;
  const seasonNumber = 1;

  const tEpisode = TvSeriesEpisode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      runtime: 1,
      stillPath: 'stillPath');

  final tTvEpisodes = <TvSeriesEpisode>[tEpisode];

  setUp(() {
    mockGetTvSeriesEpisodes = MockGetTvSeriesEpisodes();
    tvSeriesEpisodeBloc = TvSeriesEpisodeBloc(mockGetTvSeriesEpisodes);
  });

  test('Initial state should be empty', () {
    expect(tvSeriesEpisodeBloc.state, const TvSeriesEpisodeEmpty());
  });

  blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesEpisodes.execute(id, id))
          .thenAnswer((_) async => Right(tTvEpisodes));
      return tvSeriesEpisodeBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesEpisodeEvent(id, seasonNumber)),
    expect: () => [
      TvSeriesEpisodeLoading(),
      TvSeriesEpisodeHasData(tTvEpisodes),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesEpisodes.execute(id, seasonNumber));
    },
  );

  blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetTvSeriesEpisodes.execute(id, seasonNumber))
          .thenAnswer((_) async => const Right([]));
      return tvSeriesEpisodeBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesEpisodeEvent(id, seasonNumber)),
    expect: () => [
      TvSeriesEpisodeLoading(),
      const TvSeriesEpisodeEmpty("No Data"),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesEpisodes.execute(id, seasonNumber));
    },
  );

  blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetTvSeriesEpisodes.execute(id, seasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesEpisodeBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesEpisodeEvent(id, seasonNumber)),
    expect: () => [
      TvSeriesEpisodeLoading(),
      const TvSeriesEpisodeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesEpisodes.execute(id, seasonNumber));
    },
  );
}
