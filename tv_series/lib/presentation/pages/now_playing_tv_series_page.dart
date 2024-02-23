import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_event.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_state.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const routeName = '/now-playing-tv';

  const NowPlayingTvSeriesPage({super.key});

  @override
  NowPlayingTvSeriesPageState createState() => NowPlayingTvSeriesPageState();
}

class NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesNowPlayingBloc>().add(TvSeriesNowPlayingEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
          builder: (context, state) {
            if (state is TvSeriesNowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesNowPlayingHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvSeries[index];
                  return TvSeriesCard(tv);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is TvSeriesNowPlayingError) {
              return Center(
                child: Text(key: const Key('error-message'), state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
