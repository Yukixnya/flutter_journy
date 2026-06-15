import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/app.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const FitnessApp());
  });
}
