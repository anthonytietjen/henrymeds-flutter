import 'package:flutter_test/flutter_test.dart';
import 'package:henry_meds/app.dart';

void main() {
  testWidgets('Sample test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Provider Portal'), findsOneWidget);
    expect(find.text('Client Portal'), findsOneWidget);
  });
}
