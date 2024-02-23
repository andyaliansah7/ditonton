import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvSeries);
  });

  test('Initial state should be empty', () {
    expect(tvSeriesTopRatedBloc.state, const TvSeriesTopRatedEmpty());
  });

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(TvSeriesTopRatedEvent()),
    expect: () => [
      TvSeriesTopRatedLoading(),
      TvSeriesTopRatedHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(TvSeriesTopRatedEvent()),
    expect: () => [
      TvSeriesTopRatedLoading(),
      const TvSeriesTopRatedEmpty("No Data"),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(TvSeriesTopRatedEvent()),
    expect: () => [
      TvSeriesTopRatedLoading(),
      const TvSeriesTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
