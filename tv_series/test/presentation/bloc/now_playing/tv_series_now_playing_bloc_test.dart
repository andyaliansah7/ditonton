import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_event.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late TvSeriesNowPlayingBloc tvSeriesNowPlayingBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    tvSeriesNowPlayingBloc = TvSeriesNowPlayingBloc(mockGetNowPlayingTvSeries);
  });

  test('Initial state should be empty', () {
    expect(tvSeriesNowPlayingBloc.state, const TvSeriesNowPlayingEmpty());
  });

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(TvSeriesNowPlayingEvent()),
    expect: () => [
      TvSeriesNowPlayingLoading(),
      TvSeriesNowPlayingHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvSeriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(TvSeriesNowPlayingEvent()),
    expect: () => [
      TvSeriesNowPlayingLoading(),
      const TvSeriesNowPlayingEmpty("No Data"),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(TvSeriesNowPlayingEvent()),
    expect: () => [
      TvSeriesNowPlayingLoading(),
      const TvSeriesNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );
}
