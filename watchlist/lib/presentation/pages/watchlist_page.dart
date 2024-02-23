import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';
import 'package:watchlist/presentation/bloc/movie/watchlist_movie_bloc.dart';
import 'package:watchlist/presentation/bloc/movie/watchlist_movie_event.dart';
import 'package:watchlist/presentation/bloc/movie/watchlist_movie_state.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_bloc.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_event.dart';
import 'package:watchlist/presentation/bloc/tv_series/watchlist_tv_series_state.dart';
import 'package:core/utils/route_observer_utils.dart';
import 'package:flutter/material.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist';
  final int? initialIndexTab;

  const WatchlistMoviesPage({this.initialIndexTab, super.key});

  @override
  WatchlistMoviesPageState createState() => WatchlistMoviesPageState();
}

class WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
      context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
    context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialIndexTab ?? 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("Movies"),
              ),
              Tab(
                child: Text("TV Series"),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: <Widget>[
              BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                builder: (context, state) {
                  if (state is WatchlistMovieLoading) {
                    return const Center(
                      key: Key('movie-center'),
                      child: CircularProgressIndicator(
                        key: Key('movie-circular'),
                      ),
                    );
                  } else if (state is WatchlistMovieHasData) {
                    return ListView.builder(
                      key: const Key('movie-listview'),
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.result.length,
                    );
                  } else if (state is WatchlistMovieEmpty) {
                    return Center(
                      child: Text(key: const Key('movie-empty'), state.message),
                    );
                  } else if (state is WatchlistMovieError) {
                    return Center(
                      child: Text(key: const Key('movie-error'), state.message),
                    );
                  } else {
                    return Container(
                      key: const Key('movie-container'),
                    );
                  }
                },
              ),
              BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
                builder: (context, state) {
                  if (state is WatchlistTvSeriesLoading) {
                    return const Center(
                      key: Key('tv-center'),
                      child: CircularProgressIndicator(
                        key: Key('tv-circular'),
                      ),
                    );
                  } else if (state is WatchlistTvSeriesHasData) {
                    return ListView.builder(
                      key: const Key('tv-listview'),
                      itemBuilder: (context, index) {
                        final tvSeries = state.result[index];
                        return TvSeriesCard(tvSeries);
                      },
                      itemCount: state.result.length,
                    );
                  } else if (state is WatchlistTvSeriesEmpty) {
                    return Center(
                      child: Text(key: const Key('tv-empty'), state.message),
                    );
                  } else if (state is WatchlistTvSeriesError) {
                    return Center(
                      child: Text(key: const Key('tv-error'), state.message),
                    );
                  } else {
                    return Container(
                      key: const Key('tv-container'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
