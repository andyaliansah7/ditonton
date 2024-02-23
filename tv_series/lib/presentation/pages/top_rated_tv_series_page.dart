import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_state.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTvSeriesPage({super.key});

  @override
  TopRatedTvSeriesPageState createState() => TopRatedTvSeriesPageState();
}

class TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesTopRatedBloc>().add(TvSeriesTopRatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvSeries[index];
                  return TvSeriesCard(tv, index: index);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is TvSeriesTopRatedError) {
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
