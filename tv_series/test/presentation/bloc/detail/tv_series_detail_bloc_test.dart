import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_event.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_state.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  const id = 1;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });

  test('Initial state should be empty', () {
    expect(tvSeriesDetailBloc.state, TvSeriesDetailEmpty());
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(id))
          .thenAnswer((_) async => const Right(testTvSeriesDetail));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesDetailEvent(id)),
    expect: () => [
      TvSeriesDetailLoading(),
      const TvSeriesDetailHasData(testTvSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(id));
    },
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const TvSeriesDetailEvent(id)),
    expect: () => [
      TvSeriesDetailLoading(),
      const TvSeriesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(id));
    },
  );
}
