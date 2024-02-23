import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_event.dart';
import 'package:tv_series/presentation/bloc/popular/tv_series_popular_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class TvSeriesPopularEventFake extends Fake implements TvSeriesPopularEvent {}

class TvSeriesPopularStateFake extends Fake implements TvSeriesPopularState {}

class MockTvSeriesPopularBloc
    extends MockBloc<TvSeriesPopularEvent, TvSeriesPopularState>
    implements TvSeriesPopularBloc {}

void main() {
  late MockTvSeriesPopularBloc mockTvSeriesPopularBloc;

  setUp(() {
    mockTvSeriesPopularBloc = MockTvSeriesPopularBloc();
    registerFallbackValue(TvSeriesPopularEventFake());
    registerFallbackValue(TvSeriesPopularStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesPopularBloc>.value(
      value: mockTvSeriesPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display container when state is unknown',
      (WidgetTester tester) async {
    when(() => mockTvSeriesPopularBloc.state)
        .thenReturn(TvSeriesPopularStateFake());

    await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSeriesPopularBloc.state)
        .thenReturn(TvSeriesPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvSeriesPopularBloc.state)
        .thenReturn(TvSeriesPopularHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesPopularBloc.state)
        .thenReturn(const TvSeriesPopularError("Error"));

    final textFinder = find.byKey(const Key('error-message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
