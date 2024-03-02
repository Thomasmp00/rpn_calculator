// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpn_calculator/main.dart';

void main() {
  testWidgets('Calculator Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify the initial state of the calculator.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Error'), findsNothing);

    // Tap on buttons and check if the output is as expected.
    await tapButton(tester, '1');
    expect(find.text('1'), findsOneWidget);

    await tapButton(tester, '+');
    expect(find.text('1 +'), findsOneWidget);

    await tapButton(tester, '2');
    expect(find.text('1 + 2'), findsOneWidget);

    await tapButton(tester, 'Enter');
    expect(find.text('3'), findsOneWidget);

    // Add more test cases as needed...

  });
}
Future<void> tapButton(WidgetTester tester, String buttonText) async {
  await tester.tap(find.widgetWithText(ElevatedButton, buttonText));
  await tester.pump(); // Trigger a frame
  await tester.pumpAndSettle(); // Wait for animations and microtasks to complete
  await tester.pump(); // Trigger another frame
}






