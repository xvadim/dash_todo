import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}
