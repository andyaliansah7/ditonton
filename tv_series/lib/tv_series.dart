library tv_series;

export 'domain/usecases/get_now_playing_tv_series.dart';
export 'domain/usecases/get_popular_tv_series.dart';
export 'domain/usecases/get_top_rated_tv_series.dart';
export 'domain/usecases/get_tv_series_detail.dart';
export 'domain/usecases/get_tv_series_episodes.dart';
export 'domain/usecases/get_tv_series_recommendations.dart';

export 'presentation/pages/now_playing_tv_series_page.dart';
export 'presentation/pages/popular_tv_series_page.dart';
export 'presentation/pages/top_rated_tv_series_page.dart';
export 'presentation/pages/tv_series_detail_page.dart';

export 'presentation/bloc/detail/tv_series_detail_bloc.dart';
export 'presentation/bloc/detail/tv_series_detail_event.dart';
export 'presentation/bloc/detail/tv_series_detail_state.dart';

export 'presentation/bloc/episode/tv_series_episode_bloc.dart';
export 'presentation/bloc/episode/tv_series_episode_event.dart';
export 'presentation/bloc/episode/tv_series_episode_state.dart';

export 'presentation/bloc/now_playing/tv_series_now_playing_bloc.dart';
export 'presentation/bloc/now_playing/tv_series_now_playing_event.dart';
export 'presentation/bloc/now_playing/tv_series_now_playing_state.dart';

export 'presentation/bloc/popular/tv_series_popular_bloc.dart';
export 'presentation/bloc/popular/tv_series_popular_event.dart';
export 'presentation/bloc/popular/tv_series_popular_state.dart';

export 'presentation/bloc/recommendation/tv_series_recommendation_bloc.dart';
export 'presentation/bloc/recommendation/tv_series_recommendation_event.dart';
export 'presentation/bloc/recommendation/tv_series_recommendation_state.dart';

export 'presentation/bloc/top_rated/tv_series_top_rated_bloc.dart';
export 'presentation/bloc/top_rated/tv_series_top_rated_event.dart';
export 'presentation/bloc/top_rated/tv_series_top_rated_state.dart';
