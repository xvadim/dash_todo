import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dash_todo/main.dart';

void main() {
  testWidgets('Dash todO smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DashTodoApp());
  });
}
