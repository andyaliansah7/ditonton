import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_event.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc
    extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;

  TvSeriesNowPlayingBloc(this._getNowPlayingTvSeries)
      : super(const TvSeriesNowPlayingEmpty()) {
    on<TvSeriesNowPlayingEvent>((event, emit) async {
      emit(TvSeriesNowPlayingLoading());
      final result = await _getNowPlayingTvSeries.execute();
      result.fold(
        (failure) {
          emit(TvSeriesNowPlayingError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const TvSeriesNowPlayingEmpty("No Data"));
          } else {
            emit(TvSeriesNowPlayingHasData(data));
          }
        },
      );
    });
  }
}
