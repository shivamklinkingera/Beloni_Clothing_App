import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beloni_flutter/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify that we start with onboarding or sign in (depending on state)
    // Since it's a fresh test environment, it should probably show onboarding
    // but the actual screen might depend on preferences initialization.
    // For a smoke test, we just check if it builds without crashing.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
