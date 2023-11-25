import 'package:dash_todo/dash_todo_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dash todO smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DashTodoApp());
  });
}
