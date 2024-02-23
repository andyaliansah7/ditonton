import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_event.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  const id = 1;
  final tTvSeriesList = <TvSeries>[testTvSeries];

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesRecommendationBloc =
        TvSeriesRecommendationBloc(mockGetTvSeriesRecommendations);
  });

  test('Initial state should be empty', () {
    expect(
        tvSeriesRecommendationBloc.state, const TvSeriesRecommendationEmpty());
  });

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(id))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesRecommendationEvent(id)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      TvSeriesRecommendationHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(id));
    },
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(id))
          .thenAnswer((_) async => const Right([]));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesRecommendationEvent(id)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      const TvSeriesRecommendationEmpty("No Data"),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(id));
    },
  );

  blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesRecommendationEvent(id)),
    expect: () => [
      TvSeriesRecommendationLoading(),
      const TvSeriesRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(id));
    },
  );
}
