import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularBloc moviePopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  test('Initial state should be empty', () {
    expect(moviePopularBloc.state, const MoviePopularEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(MoviePopularEvent()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(MoviePopularEvent()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularEmpty("No Data"),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(MoviePopularEvent()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
