import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

void main() {
  testWidgets('Backspace should delete digits even when all digits are entered',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Pinput(
            length: 4,
            controller: controller,
          ),
        ),
      ),
    );

    // Focus the Pinput
    await tester.tap(find.byType(Pinput));
    await tester.pump();

    // Enter all 4 digits
    controller.text = '1234';
    await tester.pump();

    expect(controller.text, '1234');

    // Simulate deleting one character at a time
    controller.text = '123';
    await tester.pump();
    expect(controller.text, '123');

    controller.text = '12';
    await tester.pump();
    expect(controller.text, '12');

    controller.text = '1';
    await tester.pump();
    expect(controller.text, '1');

    controller.text = '';
    await tester.pump();
    expect(controller.text, '');

    controller.dispose();
  });

  testWidgets('Can delete and re-enter digits multiple times',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Pinput(
            length: 4,
            controller: controller,
          ),
        ),
      ),
    );

    // Focus the Pinput
    await tester.tap(find.byType(Pinput));
    await tester.pump();

    // Enter all 4 digits
    controller.text = '1234';
    await tester.pump();
    expect(controller.text, '1234');

    // Delete last digit
    controller.text = '123';
    await tester.pump();
    expect(controller.text, '123');

    // Re-enter a digit
    controller.text = '1235';
    await tester.pump();
    expect(controller.text, '1235');

    // Delete last digit again
    controller.text = '123';
    await tester.pump();
    expect(controller.text, '123');

    // Delete another digit
    controller.text = '12';
    await tester.pump();
    expect(controller.text, '12');

    controller.dispose();
  });

  testWidgets('Cursor should stay at end after tap when all digits entered',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Pinput(
            length: 4,
            controller: controller,
          ),
        ),
      ),
    );

    // Enter all 4 digits
    controller.text = '1234';
    await tester.pump();

    // Tap on the Pinput
    await tester.tap(find.byType(Pinput));
    await tester.pump();

    // Cursor should be at the end
    expect(controller.selection.baseOffset, 4);
    expect(controller.selection.extentOffset, 4);

    controller.dispose();
  });
}
