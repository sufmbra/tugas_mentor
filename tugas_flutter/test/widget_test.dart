import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/main.dart';

void main() {
  testWidgets('MyApp has a title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app has a title.
    expect(find.text('Todo App'), findsOneWidget);
  });
}
