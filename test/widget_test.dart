import 'package:flutter_test/flutter_test.dart';
import 'package:physical_event_experience/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PhysicalEventApp());
    expect(find.byType(PhysicalEventApp), findsOneWidget);
  });
}
