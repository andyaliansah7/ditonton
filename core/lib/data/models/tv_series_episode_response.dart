import 'package:core/data/models/tv_series_episode_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesEpisodeResponse extends Equatable {
  final List<TvSeriesEpisodeModel> tvSeriesEpisodeList;

  const TvSeriesEpisodeResponse({required this.tvSeriesEpisodeList});

  factory TvSeriesEpisodeResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesEpisodeResponse(
        tvSeriesEpisodeList: List<TvSeriesEpisodeModel>.from(
            (json["episodes"] as List)
                .map((x) => TvSeriesEpisodeModel.fromJson(x))
                .where((element) => element.stillPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results":
            List<dynamic>.from(tvSeriesEpisodeList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvSeriesEpisodeList];
}
