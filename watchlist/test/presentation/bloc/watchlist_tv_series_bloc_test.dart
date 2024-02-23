import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_series.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:watchlist/domain/usecases/save_watchlist_tv_series.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_event.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries
])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  final tTvSeriesList = <TvSeries>[testTvSeries];

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();

    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
        mockGetWatchlistTvSeries,
        mockGetWatchListStatusTvSeries,
        mockSaveWatchlistTvSeries,
        mockRemoveWatchlistTvSeries);
  });

  test('Initial state should be empty', () {
    expect(watchlistTvSeriesBloc.state, const WatchlistTvSeriesEmpty());
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesEmpty('No Data'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Status] when load watchlist tv series status',
    build: () {
      when(mockGetWatchListStatusTvSeries.execute(1))
          .thenAnswer((_) async => true);
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistTvSeriesStatus(1)),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatusTvSeries.execute(1));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Message] when add watchlist is successfully',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const AddWatchlistTvSeries(testTvSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Message] when add watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const AddWatchlistTvSeries(testTvSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesError('Error'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Message] when remove watchlist is successfully',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const DeleteWatchlistTvSeries(testTvSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesMessage('Removed from Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Message] when remove watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const DeleteWatchlistTvSeries(testTvSeriesDetail)),
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesError('Error'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
    },
  );
}
