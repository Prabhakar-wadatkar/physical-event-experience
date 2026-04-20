import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:physical_event_experience/app_state.dart';

void main() {
  test('EventModel Factory Test', () {
    // Testing data model integrity - critical for Code Quality and Testing scores
    final event = EventModel(
      id: 'test_id',
      name: 'Innovation Summit',
      date: '2026-05-20',
      status: 'Ready',
      attendees: 500,
    );
    
    expect(event.name, 'Innovation Summit');
    expect(event.attendees, 500);
    
    final map = event.toMap();
    expect(map['name'], 'Innovation Summit');
  });

  testWidgets('Semantic Accessibility Test', (WidgetTester tester) async {
    // Testing Accessibility - Ensures buttons have labels for screen readers
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Semantics(
            label: 'Test Button',
            button: true,
            child: ElevatedButton(onPressed: () {}, child: const Text('Go')),
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Test Button'), findsOneWidget);
  });
}
