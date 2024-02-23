import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_series.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:watchlist/domain/usecases/save_watchlist_tv_series.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_event.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;
  final GetWatchListStatusTvSeries _getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  WatchlistTvSeriesBloc(
      this._getWatchlistTvSeries,
      this._getWatchListStatusTvSeries,
      this._saveWatchlistTvSeries,
      this._removeWatchlistTvSeries)
      : super(const WatchlistTvSeriesEmpty()) {
    on<FetchWatchlistTvSeries>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await _getWatchlistTvSeries.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const WatchlistTvSeriesEmpty("No Data"));
          } else {
            emit(WatchlistTvSeriesHasData(data));
          }
        },
      );
    });

    on<LoadWatchlistTvSeriesStatus>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await _getWatchListStatusTvSeries.execute(event.id);
      emit(WatchlistTvSeriesStatus(result));
    });

    on<AddWatchlistTvSeries>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await _saveWatchlistTvSeries.execute(event.tvSeriesDetail);

      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure.message)),
        (success) async {
          emit(WatchlistTvSeriesMessage(success));
        },
      );
    });

    on<DeleteWatchlistTvSeries>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result =
          await _removeWatchlistTvSeries.execute(event.tvSeriesDetail);
      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure.message)),
        (success) => emit(WatchlistTvSeriesMessage(success)),
      );
    });
  }
}
