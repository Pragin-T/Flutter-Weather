// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// IMPORTANT: Change this import to match your project's main file.
import 'package:flutter_proj/main.dart';

void main() {
  testWidgets('Weather App initial state test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We now use the correct WeatherApp widget.
    await tester.pumpWidget(const WeatherApp());

    // Allow the app time to show the loading indicator while it fetches the location/weather.
    await tester.pump();

    // Verify that the initial UI shows a loading indicator while permissions are requested.
    // This is a good initial test before the API returns data.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Verify that the main search bar is present.
    expect(find.widgetWithText(TextField, 'Search for a city'), findsOneWidget);

    // Verify that the search icon is present.
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
