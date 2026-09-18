import 'package:flutter_test/flutter_test.dart';
import 'package:paulo_portfolio/main.dart';

void main() {
  testWidgets('renders portfolio shell', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.textContaining('Paulo'), findsWidgets);
  });
}
