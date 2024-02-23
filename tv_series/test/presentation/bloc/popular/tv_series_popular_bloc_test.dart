import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    tvSeriesPopularBloc = TvSeriesPopularBloc(mockGetPopularTvSeries);
  });

  test('Initial state should be empty', () {
    expect(tvSeriesPopularBloc.state, const TvSeriesPopularEmpty());
  });

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesPopularBloc;
    },
    act: (bloc) => bloc.add(TvSeriesPopularEvent()),
    expect: () => [
      TvSeriesPopularLoading(),
      TvSeriesPopularHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvSeriesPopularBloc;
    },
    act: (bloc) => bloc.add(TvSeriesPopularEvent()),
    expect: () => [
      TvSeriesPopularLoading(),
      const TvSeriesPopularEmpty("No Data"),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesPopularBloc;
    },
    act: (bloc) => bloc.add(TvSeriesPopularEvent()),
    expect: () => [
      TvSeriesPopularLoading(),
      const TvSeriesPopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
