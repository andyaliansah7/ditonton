import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_event.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  test('LoadWatchlistTvSeriesStatus props should contain id', () {
    const id = 1;
    expect(const LoadWatchlistTvSeriesStatus(id).props, [id]);
  });

  test('AddWatchlistTvSeries props should contain movieDetail', () {
    const tvSeriesDetail = testTvSeriesDetail;
    expect(const AddWatchlistTvSeries(tvSeriesDetail).props, [tvSeriesDetail]);
  });

  test('DeleteWatchlistTvSeries props should contain movieDetail', () {
    const tvSeriesDetail = testTvSeriesDetail;
    expect(
        const DeleteWatchlistTvSeries(tvSeriesDetail).props, [tvSeriesDetail]);
  });
}
