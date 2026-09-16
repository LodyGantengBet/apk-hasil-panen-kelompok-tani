import 'package:flutter_test/flutter_test.dart';
import 'package:kopdes/main.dart';

void main() {
  testWidgets('KOPDES app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KopdesApp());
    expect(find.text('KOPDES'), findsWidgets);
  });
}
