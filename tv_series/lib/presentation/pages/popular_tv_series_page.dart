import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_state.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

import '../bloc/popular/tv_series_popular_event.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTvSeriesPage({super.key});

  @override
  PopularTvSeriesPageState createState() => PopularTvSeriesPageState();
}

class PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesPopularBloc>().add(TvSeriesPopularEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvSeries[index];
                  return TvSeriesCard(tv);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is TvSeriesPopularError) {
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
