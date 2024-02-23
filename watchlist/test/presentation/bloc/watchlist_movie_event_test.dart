import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/presentation/bloc/movie/watchlist_movie_event.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  test('LoadWatchlistMovieStatus props should contain id', () {
    const id = 1;
    expect(const LoadWatchlistMovieStatus(id).props, [id]);
  });

  test('AddWatchlistMovie props should contain movieDetail', () {
    const movieDetail = testMovieDetail;
    expect(const AddWatchlistMovie(movieDetail).props, [movieDetail]);
  });

  test('DeleteWatchlistMovie props should contain movieDetail', () {
    const movieDetail = testMovieDetail;
    expect(const DeleteWatchlistMovie(movieDetail).props, [movieDetail]);
  });
}
