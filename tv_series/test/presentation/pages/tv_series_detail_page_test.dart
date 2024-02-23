import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series_episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';

class TvSeriesDetailEventFake extends Fake implements TvSeriesDetailEvent {}

class TvSeriesDetailStateFake extends Fake implements TvSeriesDetailState {}

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class WatchlistTvSeriesEventFake extends Fake
    implements WatchlistTvSeriesEvent {}

class WatchlistTvSeriesStateFake extends Fake
    implements WatchlistTvSeriesState {}

class MockWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class TvSeriesRecommendationEventFake extends Fake
    implements TvSeriesRecommendationEvent {}

class TvSeriesRecommendationStateFake extends Fake
    implements TvSeriesRecommendationState {}

class MockTvSeriesRecommendationBloc
    extends MockBloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState>
    implements TvSeriesRecommendationBloc {}

class TvSeriesEpisodeEventFake extends Fake implements TvSeriesEpisodeEvent {}

class TvSeriesEpisodeStateFake extends Fake implements TvSeriesEpisodeState {}

class MockTvSeriesEpisodeBloc
    extends MockBloc<TvSeriesEpisodeEvent, TvSeriesEpisodeState>
    implements TvSeriesEpisodeBloc {}

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesRecommendationBloc mockTvSeriesRecommendationBloc;
  late MockTvSeriesEpisodeBloc mockTvSeriesEpisodeBloc;
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;

  const tEpisode = TvSeriesEpisode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      runtime: 1,
      stillPath: 'stillPath');

  final tTvEpisodes = <TvSeriesEpisode>[tEpisode];

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesRecommendationBloc = MockTvSeriesRecommendationBloc();
    mockTvSeriesEpisodeBloc = MockTvSeriesEpisodeBloc();
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();

    registerFallbackValue(TvSeriesDetailEventFake());
    registerFallbackValue(TvSeriesDetailStateFake());
    registerFallbackValue(TvSeriesRecommendationEventFake());
    registerFallbackValue(TvSeriesRecommendationStateFake());
    registerFallbackValue(TvSeriesEpisodeEventFake());
    registerFallbackValue(TvSeriesEpisodeStateFake());
    registerFallbackValue(WatchlistTvSeriesEventFake());
    registerFallbackValue(WatchlistTvSeriesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => mockTvSeriesDetailBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (context) => mockWatchlistTvSeriesBloc,
        ),
        BlocProvider<TvSeriesRecommendationBloc>(
          create: (context) => mockTvSeriesRecommendationBloc,
        ),
        BlocProvider<TvSeriesEpisodeBloc>(
          create: (context) => mockTvSeriesEpisodeBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailLoading());

    final progressBarFinder = find.byKey(const Key('detail-circular'));
    final centerFinder = find.byKey(const Key('detail-center'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    final listViewFinder = find.byType(ListView);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailError("Error"));

    final textFinder = find.byKey(const Key('detail-error-message'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Button should display add icon when tvSeries not in wathclist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Button should display add icon when tvSeries in wathclist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(true));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Page should display center progress bar when tvSeries recommendation is loading',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationLoading());
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    final progressBarFinder = find.byKey(const Key('recommendation-circular'));
    final centerFinder = find.byKey(const Key('recommendation-center'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display ListView when data tvSeries recommendation is is loaded',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    final listViewFinder = find.byKey(const Key('recommendation-listview'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when tvSeries recommendation is Empty',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(const TvSeriesRecommendationEmpty("No Data"));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    final textFinder = find.byKey(const Key('recommendation-empty-message'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when tvSeries recommendation is Error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(const TvSeriesRecommendationError("Error"));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    final textFinder = find.byKey(const Key('recommendation-error-message'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display Snacbar when add tvSeries to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));
    whenListen(mockWatchlistTvSeriesBloc,
        Stream.fromIterable([const WatchlistTvSeriesMessage("Test message")]));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final watchlistButton = find.byKey(const Key('watchlist-button'));
    expect(watchlistButton, findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Page should display Snacbar when remove tvSeries from watchlist',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(true));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));
    whenListen(mockWatchlistTvSeriesBloc,
        Stream.fromIterable([const WatchlistTvSeriesMessage("Test message")]));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    final watchlistButton = find.byKey(const Key('watchlist-button'));
    expect(watchlistButton, findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when tvSeries episode is Empty',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(const TvSeriesEpisodeEmpty('No Data'));

    final textFinder = find.byKey(const Key('episode-empty-message'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when tvSeries recommendation is Error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(const TvSeriesEpisodeError('Error'));

    final textFinder = find.byKey(const Key('episode-error-message'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display listview episode when season is tapped',
      (WidgetTester tester) async {
    when(() => mockTvSeriesDetailBloc.state)
        .thenReturn(const TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesStatus(false));
    when(() => mockTvSeriesRecommendationBloc.state)
        .thenReturn(TvSeriesRecommendationHasData(testTvSeriesList));
    when(() => mockTvSeriesEpisodeBloc.state)
        .thenReturn(TvSeriesEpisodeHasData(tTvEpisodes));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 62560)));

    final seasonButton = find.byKey(const Key('season-button'));
    expect(seasonButton, findsOneWidget);

    await tester.ensureVisible(seasonButton);
    await tester.tap(seasonButton);
    await tester.pump();

    verify(() => mockTvSeriesEpisodeBloc.add(
          const TvSeriesEpisodeEvent(1, 1),
        )).called(1);

    await tester.pump();

    expect(find.byKey(const Key('episode-listview')), findsOneWidget);
  });
}
