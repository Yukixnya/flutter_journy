import 'package:flutter_test/flutter_test.dart';
import 'package:quote_gen_app/app.dart';
import 'package:quote_gen_app/models/quote_list.dart';

void main() {
  testWidgets('Quote is displayed after button click',
      (WidgetTester tester) async {

    await tester.pumpWidget(const QuoteGenApp());

    await tester.tap(find.text('Generate Quote'));
    await tester.pump();

    bool foundQuote = false;

    for (String quote in quotes) {
      if (find.text("''$quote''").evaluate().isNotEmpty) {
        foundQuote = true;
        break;
      }
    }

    expect(foundQuote, true);
    // expect(find.text('Generate Quote'), findsOneWidget);
  });
}