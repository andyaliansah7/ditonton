import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_tv_series_episodes.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_event.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_state.dart';

class TvSeriesEpisodeBloc
    extends Bloc<TvSeriesEpisodeEvent, TvSeriesEpisodeState> {
  final GetTvSeriesEpisodes getTvSeriesEpisodes;

  TvSeriesEpisodeBloc(this.getTvSeriesEpisodes)
      : super(const TvSeriesEpisodeEmpty()) {
    on<TvSeriesEpisodeEvent>((event, emit) async {
      emit(TvSeriesEpisodeLoading());
      final result =
          await getTvSeriesEpisodes.execute(event.id, event.seasonNumber);
      result.fold(
        (failure) {
          emit(TvSeriesEpisodeError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(const TvSeriesEpisodeEmpty("No Data"));
          } else {
            emit(TvSeriesEpisodeHasData(data));
          }
        },
      );
    });
  }
}
