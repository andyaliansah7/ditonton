import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';
import 'package:search/presentation/bloc/movie/search_movie_event.dart';
import 'package:search/presentation/bloc/movie/search_movie_state.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_bloc.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_event.dart';
import 'package:search/presentation/bloc/tv_series/search_tv_series_state.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';
  final int? initialIndexTab;

  const SearchPage({this.initialIndexTab, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndexTab ?? 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (query) {
                  context.read<SearchMovieBloc>().add(SearchMovieEvent(query));
                  context
                      .read<SearchTvSeriesBloc>()
                      .add(SearchTvSeriesEvent(query));
                },
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              const TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text("Movies"),
                  ),
                  Tab(
                    child: Text("TV Series"),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Column(
                      children: [
                        BlocBuilder<SearchMovieBloc, SearchMovieState>(
                          builder: (context, state) {
                            if (state is SearchMovieLoading) {
                              return const Center(
                                key: Key('movie-center'),
                                child: CircularProgressIndicator(
                                    key: Key('movie-circular')),
                              );
                            } else if (state is SearchMovieHasData) {
                              final result = state.result;
                              return Expanded(
                                child: ListView.builder(
                                  key: const Key('movie-listview'),
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    final movie = result[index];
                                    return MovieCard(movie);
                                  },
                                  itemCount: result.length,
                                ),
                              );
                            } else if (state is SearchMovieEmpty) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                      key: const Key('movie-empty'),
                                      state.message),
                                ),
                              );
                            } else if (state is SearchMovieError) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                      key: const Key('movie-error'),
                                      state.message),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                          builder: (context, state) {
                            if (state is SearchTvSeriesLoading) {
                              return const Center(
                                key: Key('tv-center'),
                                child: CircularProgressIndicator(
                                    key: Key('tv-circular')),
                              );
                            } else if (state is SearchTvSeriesHasData) {
                              final result = state.result;
                              return Expanded(
                                child: ListView.builder(
                                  key: const Key('tv-listview'),
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    final tvSeries = result[index];
                                    return TvSeriesCard(tvSeries);
                                  },
                                  itemCount: result.length,
                                ),
                              );
                            } else if (state is SearchTvSeriesEmpty) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                      key: const Key('tv-empty'),
                                      state.message),
                                ),
                              );
                            } else if (state is SearchTvSeriesError) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                      key: const Key('tv-error'),
                                      state.message),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
