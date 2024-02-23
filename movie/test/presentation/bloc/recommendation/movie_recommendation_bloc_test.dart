import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  const id = 1;
  final tMovieList = <Movie>[testMovie];

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc =
        MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  test('Initial state should be empty', () {
    expect(movieRecommendationBloc.state, const MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => Right(tMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const MovieRecommendationEvent(id)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => const Right([]));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const MovieRecommendationEvent(id)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationEmpty("No Data"),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const MovieRecommendationEvent(id)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
    },
  );
}
