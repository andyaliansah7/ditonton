import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_event.dart';
import 'package:tv_series/presentation/bloc/top_rated/tv_series_top_rated_state.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class TvSeriesTopRatedEventFake extends Fake implements TvSeriesTopRatedEvent {}

class TvSeriesTopRatedStateFake extends Fake implements TvSeriesTopRatedState {}

class MockTvSeriesTopRatedBloc
    extends MockBloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState>
    implements TvSeriesTopRatedBloc {}

void main() {
  late MockTvSeriesTopRatedBloc mockTvSeriesTopRatedBloc;

  setUp(() {
    mockTvSeriesTopRatedBloc = MockTvSeriesTopRatedBloc();
    registerFallbackValue(TvSeriesTopRatedEventFake());
    registerFallbackValue(TvSeriesTopRatedStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesTopRatedBloc>.value(
      value: mockTvSeriesTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display container when state is unknown',
      (WidgetTester tester) async {
    when(() => mockTvSeriesTopRatedBloc.state)
        .thenReturn(TvSeriesTopRatedStateFake());

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSeriesTopRatedBloc.state)
        .thenReturn(TvSeriesTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvSeriesTopRatedBloc.state)
        .thenReturn(TvSeriesTopRatedHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesTopRatedBloc.state)
        .thenReturn(const TvSeriesTopRatedError("Error"));

    final textFinder = find.byKey(const Key('error-message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
