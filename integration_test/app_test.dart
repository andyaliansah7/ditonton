import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  group('Testing App', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("All Around", (tester) async {
      await binding.traceAction(() async {
        app.main();
        await tester.pumpAndSettle();

        // Search
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'spiderman');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        await tester.scrollUntilVisible(
            find.byKey(const Key('movie-634649')), 100,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        // Detail
        await tester.tap(find.byKey(const Key('movie-634649')));
        await tester.pumpAndSettle();

        // Add to Watchlist
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        // Back
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // TV Series Top Rated List
        await tester.scrollUntilVisible(
            find.byKey(const Key('tv-top-rated')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        final areaTvTopRated = find.byKey(const Key('tv-top-rated'));
        final seeMoreButton = find.descendant(
          of: areaTvTopRated,
          matching: find.byIcon(Icons.arrow_forward_ios),
        );

        await tester.tap(seeMoreButton);
        await tester.pumpAndSettle();

        // TV Series Detail
        await tester.scrollUntilVisible(find.byKey(const Key('tv-8')), 500,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key('tv-8')));
        await tester.pumpAndSettle();

        // Add to Watchlist
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        // Remove from Watchlist
        await tester.tap(find.byIcon(Icons.check));
        await tester.pumpAndSettle();

        // Season & Episode
        await tester.scrollUntilVisible(
            find.byKey(const Key('listview-season')), 300,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key('season-button-2')));
        await tester.pumpAndSettle();

        await tester.scrollUntilVisible(
            find.byKey(const Key('episode-listview')), 100,
            scrollable: find.byType(Scrollable).last);
        await tester.pumpAndSettle();

        // Back
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Menu
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        // Watchlist
        await tester.tap(find.byIcon(Icons.save_alt));
        await tester.pumpAndSettle();

        await tester.tap(find.text('TV Series'));
        await tester.pumpAndSettle();
      });
    });
  });
}
