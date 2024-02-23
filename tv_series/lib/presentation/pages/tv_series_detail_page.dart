import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/utils/colors.dart';
import 'package:core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_event.dart';
import 'package:tv_series/presentation/bloc/detail/tv_series_detail_state.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_event.dart';
import 'package:tv_series/presentation/bloc/episode/tv_series_episode_state.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_event.dart';
import 'package:tv_series/presentation/bloc/recommendation/tv_series_recommendation_state.dart';
import 'package:watchlist/watchlist.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv';

  final int id;
  const TvSeriesDetailPage({super.key, required this.id});

  @override
  TvSeriesDetailPageState createState() => TvSeriesDetailPageState();
}

class TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>().add(TvSeriesDetailEvent(widget.id));
      context
          .read<TvSeriesRecommendationBloc>()
          .add(TvSeriesRecommendationEvent(widget.id));
      context
          .read<TvSeriesEpisodeBloc>()
          .add(TvSeriesEpisodeEvent(widget.id, 1));
      context
          .read<WatchlistTvSeriesBloc>()
          .add(LoadWatchlistTvSeriesStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoading) {
            return const Center(
              key: Key("detail-center"),
              child: CircularProgressIndicator(
                key: Key("detail-circular"),
              ),
            );
          } else if (state is TvSeriesDetailHasData) {
            final tv = state.tvSeriesDetail;
            return SafeArea(
              child: DetailContent(tv),
            );
          } else if (state is TvSeriesDetailError) {
            return Center(
              child:
                  Text(key: const Key('detail-error-message'), state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;

  const DetailContent(this.tvSeriesDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final episodeBloc = context.read<TvSeriesEpisodeBloc>();

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            BlocListener<WatchlistTvSeriesBloc,
                                WatchlistTvSeriesState>(
                              listener: (context, state) {
                                if (state is WatchlistTvSeriesMessage) {
                                  final message = state.message;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(message),
                                  ));
                                }
                              },
                              child: BlocBuilder<WatchlistTvSeriesBloc,
                                  WatchlistTvSeriesState>(
                                builder: (context, state) {
                                  if (state is WatchlistTvSeriesStatus) {
                                    return ElevatedButton(
                                      key: const Key('watchlist-button'),
                                      onPressed: () async {
                                        final watchlistBloc = context
                                            .read<WatchlistTvSeriesBloc>();
                                        if (!state.status) {
                                          watchlistBloc.add(
                                              AddWatchlistTvSeries(
                                                  tvSeriesDetail));
                                        } else {
                                          watchlistBloc.add(
                                              DeleteWatchlistTvSeries(
                                                  tvSeriesDetail));
                                        }
                                        watchlistBloc.add(
                                            LoadWatchlistTvSeriesStatus(
                                                tvSeriesDetail.id));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          state.status
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.add),
                                          const Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return ElevatedButton(
                                      onPressed: () async {},
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: CircularProgressIndicator(),
                                          ),
                                          Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons & Episodes',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                key: const Key('listview-season'),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season = tvSeriesDetail.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      key: const Key('season-button'),
                                      onTap: () {
                                        episodeBloc.add(TvSeriesEpisodeEvent(
                                            tvSeriesDetail.id,
                                            season.seasonNumber!));
                                      },
                                      child: ClipRRect(
                                        key: Key('season-button-$index'),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              SizedBox(
                                                  width: 100,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons.error),
                                                      Text(season.name!)
                                                    ],
                                                  )),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: tvSeriesDetail.seasons.length,
                              ),
                            ),
                            BlocBuilder<TvSeriesEpisodeBloc,
                                TvSeriesEpisodeState>(
                              builder: (context, state) {
                                if (state is TvSeriesEpisodeLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvSeriesEpisodeHasData) {
                                  if (state.tvSeriesEpisode.isNotEmpty) {
                                    return SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        key: const Key('episode-listview'),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final episode =
                                              state.tvSeriesEpisode[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 14,
                                                  right: 14,
                                                  left: 14,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(episode.name!,
                                                          style: kSubtitle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                      Text(
                                                        episode.overview!,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: state.tvSeriesEpisode.length,
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("Episode List Not Available"),
                                    );
                                  }
                                } else if (state is TvSeriesEpisodeEmpty) {
                                  return Text(
                                      key: const Key('episode-empty-message'),
                                      state.message);
                                } else if (state is TvSeriesEpisodeError) {
                                  return Text(
                                      key: const Key('episode-error-message'),
                                      state.message);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvSeriesRecommendationBloc,
                                TvSeriesRecommendationState>(
                              builder: (context, state) {
                                if (state is TvSeriesRecommendationLoading) {
                                  return const Center(
                                    key: Key('recommendation-center'),
                                    child: CircularProgressIndicator(
                                        key: Key('recommendation-circular')),
                                  );
                                } else if (state
                                    is TvSeriesRecommendationHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      key: const Key('recommendation-listview'),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.tvSeries[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.routeName,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.tvSeries.length,
                                    ),
                                  );
                                } else if (state
                                    is TvSeriesRecommendationEmpty) {
                                  return Text(
                                      key: const Key(
                                          'recommendation-empty-message'),
                                      state.message);
                                } else if (state
                                    is TvSeriesRecommendationError) {
                                  return Text(
                                      key: const Key(
                                          'recommendation-error-message'),
                                      state.message);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
