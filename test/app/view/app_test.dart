import 'package:flutter_test/flutter_test.dart';
import 'package:thinkbit_todo/app/view/app.dart';
import 'package:thinkbit_todo/todo/view/todo_page.dart';

void main() {
  group('App', () {
    testWidgets('renders TodoPage', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());
      expect(find.byType(TodoPage), findsOneWidget);
    });
  });
}
