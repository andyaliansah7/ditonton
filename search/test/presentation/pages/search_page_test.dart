import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

import '../../dummy_data/dummy_objects.dart';

class SearchMovieEventFake extends Fake implements SearchMovieEvent {}

class SearchMovieStateFake extends Fake implements SearchMovieState {}

class MockSearchMovieBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

class SearchTvSeriesEventFake extends Fake implements SearchTvSeriesEvent {}

class SearchTvSeriesStateFake extends Fake implements SearchTvSeriesState {}

class MockSearchTvSeriesBloc
    extends MockBloc<SearchTvSeriesEvent, SearchTvSeriesState>
    implements SearchTvSeriesBloc {}

void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;
  late MockSearchTvSeriesBloc mockSearchTvSeriesBloc;

  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
    mockSearchTvSeriesBloc = MockSearchTvSeriesBloc();

    registerFallbackValue(SearchMovieEventFake());
    registerFallbackValue(SearchMovieStateFake());
    registerFallbackValue(SearchTvSeriesEventFake());
    registerFallbackValue(SearchTvSeriesStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMovieBloc>(
          create: (context) => mockSearchMovieBloc,
        ),
        BlocProvider<SearchTvSeriesBloc>(
          create: (context) => mockSearchTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Verify that event triggered when enter text to search movie and tv series',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMovieLoading());
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(SearchTvSeriesLoading());
    final textFieldFinder = find.byType(TextField);

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 0)));

    await tester.enterText(textFieldFinder, "spiderman");

    verify(() => mockSearchMovieBloc.add(any(that: isA<SearchMovieEvent>())))
        .called(1);
    verify(() =>
            mockSearchTvSeriesBloc.add(any(that: isA<SearchTvSeriesEvent>())))
        .called(1);
  });

  testWidgets(
      'Page should display center progress bar when search movie is loading',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMovieLoading());

    final progressBarFinder = find.byKey(const Key('movie-circular'));
    final centerFinder = find.byKey(const Key('movie-center'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 0)));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when search movie is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state)
        .thenReturn(SearchMovieHasData(testMovieList));

    final listviewFinder = find.byKey(const Key('movie-listview'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 0)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when search movie is empty',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state)
        .thenReturn(const SearchMovieEmpty('No Data'));

    final listviewFinder = find.byKey(const Key('movie-empty'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 0)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when search movie is error',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state)
        .thenReturn(const SearchMovieError('Error'));

    final listviewFinder = find.byKey(const Key('movie-error'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 0)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets('Page should display center progress bar when tv loading',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(SearchTvSeriesLoading());

    final progressBarFinder = find.byKey(const Key('tv-circular'));
    final centerFinder = find.byKey(const Key('tv-center'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 1)));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when search tv series is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(SearchTvSeriesHasData(testTvSeriesList));

    final listviewFinder = find.byKey(const Key('tv-listview'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 1)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when search movie is empty',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(const SearchTvSeriesEmpty('No Data'));

    final listviewFinder = find.byKey(const Key('tv-empty'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 1)));

    expect(listviewFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when search movie is error',
      (WidgetTester tester) async {
    when(() => mockSearchTvSeriesBloc.state)
        .thenReturn(const SearchTvSeriesError('Error'));

    final listviewFinder = find.byKey(const Key('tv-error'));

    await tester
        .pumpWidget(makeTestableWidget(const SearchPage(initialIndexTab: 1)));

    expect(listviewFinder, findsOneWidget);
  });
}
