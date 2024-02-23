import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_event.dart';
import 'package:tv_series/presentation/bloc/now_playing/tv_series_now_playing_state.dart';
import 'package:tv_series/presentation/pages/now_playing_tv_series_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class TvSeriesNowPlayingEventFake extends Fake
    implements TvSeriesNowPlayingEvent {}

class TvSeriesNowPlayingStateFake extends Fake
    implements TvSeriesNowPlayingState {}

class MockTvSeriesNowPlayingBloc
    extends MockBloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState>
    implements TvSeriesNowPlayingBloc {}

void main() {
  late MockTvSeriesNowPlayingBloc mockTvSeriesNowPlayingBloc;

  setUp(() {
    mockTvSeriesNowPlayingBloc = MockTvSeriesNowPlayingBloc();
    registerFallbackValue(TvSeriesNowPlayingEventFake());
    registerFallbackValue(TvSeriesNowPlayingStateFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesNowPlayingBloc>.value(
      value: mockTvSeriesNowPlayingBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display container when state is unknown',
      (WidgetTester tester) async {
    when(() => mockTvSeriesNowPlayingBloc.state)
        .thenReturn(TvSeriesNowPlayingStateFake());

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSeriesNowPlayingBloc.state)
        .thenReturn(TvSeriesNowPlayingLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvSeriesNowPlayingBloc.state)
        .thenReturn(TvSeriesNowPlayingHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesNowPlayingBloc.state)
        .thenReturn(const TvSeriesNowPlayingError("Error"));

    final textFinder = find.byKey(const Key('error-message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
