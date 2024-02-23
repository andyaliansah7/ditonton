import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';

class WatchlistMovieEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMovieStateFake extends Fake implements WatchlistMovieState {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class WatchlistTvSeriesEventFake extends Fake
    implements WatchlistTvSeriesEvent {}

class WatchlistTvSeriesStateFake extends Fake
    implements WatchlistTvSeriesState {}

class MockWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

void main() {
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;

  setUp(() {
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();

    registerFallbackValue(WatchlistMovieEventFake());
    registerFallbackValue(WatchlistMovieStateFake());
    registerFallbackValue(WatchlistTvSeriesEventFake());
    registerFallbackValue(WatchlistTvSeriesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => mockWatchlistMovieBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (context) => mockWatchlistTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display container when movie state is unknown',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieStateFake());

    final containerFinder = find.byKey(const Key('movie-container'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(containerFinder, findsWidgets);
  });

  testWidgets('Page should display container when tv series state is unknown',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesStateFake());

    final containerFinder = find.byKey(const Key('tv-container'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 1)));

    expect(containerFinder, findsWidgets);
  });

  testWidgets(
      'Page should display center progress bar when watchlist movie is loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoading());

    final progressBarFinder = find.byKey(const Key('movie-circular'));
    final centerFinder = find.byKey(const Key('movie-center'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 0)));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when watchlist movie is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieHasData(testMovieList));

    final listviewFinder = find.byKey(const Key('movie-listview'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 0)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when watchlist movie is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieEmpty('No Data'));

    final listviewFinder = find.byKey(const Key('movie-empty'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 0)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when watchlist movie is error',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMovieError('Error'));

    final listviewFinder = find.byKey(const Key('movie-error'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 0)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when tv loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());

    final progressBarFinder = find.byKey(const Key('tv-circular'));
    final centerFinder = find.byKey(const Key('tv-center'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 1)));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when watchlist tv series is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesHasData(testTvSeriesList));

    final listviewFinder = find.byKey(const Key('tv-listview'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 1)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when watchlist movie is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesEmpty('No Data'));

    final listviewFinder = find.byKey(const Key('tv-empty'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 1)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when watchlist movie is error',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvSeriesBloc.state)
        .thenReturn(const WatchlistTvSeriesError('Error'));

    final listviewFinder = find.byKey(const Key('tv-error'));

    await tester.pumpWidget(
        makeTestableWidget(const WatchlistMoviesPage(initialIndexTab: 1)));

    expect(listviewFinder, findsOneWidget);
  });
}
