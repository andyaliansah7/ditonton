import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class WatchlistMovieEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMovieStateFake extends Fake implements WatchlistMovieState {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class MovieRecommendationEventFake extends Fake
    implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends Fake
    implements MovieRecommendationState {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();

    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieRecommendationEventFake());
    registerFallbackValue(MovieRecommendationStateFake());
    registerFallbackValue(WatchlistMovieEventFake());
    registerFallbackValue(WatchlistMovieStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => mockWatchlistMovieBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => mockMovieRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());

    final progressBarFinder = find.byKey(const Key('detail-circular'));
    final centerFinder = find.byKey(const Key('detail-center'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(false));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailError("Error"));

    final textFinder = find.byKey(const Key('detail-error-message'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Button should display add icon when movie not in wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(false));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Button should display add icon when movie in wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(true));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Page should display center progress bar when movie recommendation is loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(false));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationLoading());

    final progressBarFinder = find.byKey(const Key('recommendation-circular'));
    final centerFinder = find.byKey(const Key('recommendation-center'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display ListView when data movie recommendation is is loaded',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(false));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    final listViewFinder = find.byKey(const Key('recommendation-listview'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when movie recommendation is Empty',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(false));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(const MovieRecommendationEmpty("No Data"));

    final textFinder = find.byKey(const Key('recommendation-empty-message'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when movie recommendation is Error',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(false));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(const MovieRecommendationError("Error"));

    final textFinder = find.byKey(const Key('recommendation-error-message'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display Snacbar when add movie to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(false));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    whenListen(mockWatchlistMovieBloc,
        Stream.fromIterable([const WatchlistMovieMessage("Test message")]));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    final watchlistButton = find.byKey(const Key('watchlist-button'));
    expect(watchlistButton, findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Page should display Snacbar when remove movie from watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieStatus(true));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    whenListen(mockWatchlistMovieBloc,
        Stream.fromIterable([const WatchlistMovieMessage("Test message")]));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    final watchlistButton = find.byKey(const Key('watchlist-button'));
    expect(watchlistButton, findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });
}
