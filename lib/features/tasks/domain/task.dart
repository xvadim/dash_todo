import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required int id,
    @Default(false) bool isCompleted,
    @Default('') String priority,
    DateTime? completionDate,
    DateTime? creationDate,
    required String text,
    @Default([]) List<String> projects,
    @Default([]) List<String> contexts,
    @Default('') String rawString,
  }) = _Task;

  // see https://github.com/todotxt/todo.txt
  // 'x (A) 2023-11-17 2023-11-16 some text +projectTag @contextTag another txt'
  factory Task.fromString(int id, String string) {
    final rawString = string;

    // don't use regexp for such simple checks
    bool isCompleted = false;
    if (string.startsWith(_completionMark)) {
      isCompleted = true;
      string = string.removePrefix(_completionMarkLength);
    }

    String priority = '';
    if (string.length >= _priorityMarkLength &&
        string[0] == '(' &&
        string[2] == ')' &&
        string[3] == ' ' &&
        _priorityMarks.contains(string[1])) {
      priority = string[1];
      string = string.removePrefix(_priorityMarkLength);
    }

    DateTime? startDate;
    DateTime? endDate;

    (endDate, startDate, string) = _parseDates(string, isCompleted);

    return Task(
      id: id,
      isCompleted: isCompleted,
      priority: priority,
      completionDate: endDate,
      creationDate: startDate,
      text: string,
      projects: _parseProjects(string),
      contexts: _parseContexts(string),
      rawString: rawString,
    );
  }
}

//TODO: add the compareTo method & Comparable interface
extension TaskEx on Task {
  String toRawString() {
    if (rawString.isNotEmpty) {
      if (isCompleted && !rawString.startsWith(_completionMark)) {
        return '$_completionMark$rawString';
      }
      return rawString;
    }
    final buffer = StringBuffer();
    if (isCompleted) {
      buffer.write('x');
      buffer.write(' ');
    }
    if (priority.isNotEmpty) {
      buffer.write('($priority) ');
    }
    if (completionDate != null) {
      buffer.write(_dateFormatter.format(completionDate!));
    }
    if (creationDate != null) {
      buffer.write(_dateFormatter.format(creationDate!));
    }
    buffer.write(text);
    if (projects.isNotEmpty || contexts.isNotEmpty) {
      buffer.write(' ');
    }
    buffer.writeAll(projects.map((p) => '+$p'), ' ');
    if (contexts.isNotEmpty) buffer.write(' ');
    buffer.writeAll(contexts.map((c) => '@$c'), ' ');
    return buffer.toString();
  }
}

// Returns (completion date, creation date, rest of the string)
(DateTime?, DateTime?, String) _parseDates(
  String string,
  bool isCompleted,
) {
  DateTime? startDate;
  DateTime? endDate;

  String? dateStr = _dateRegexp.stringMatch(string);
  if (dateStr != null) {
    try {
      DateTime taskDate = _dateFormatter.parseStrict(dateStr);
      string = string.removePrefix(_dateLength);
      if (!isCompleted) {
        startDate = taskDate;
      } else {
        endDate = taskDate;
        dateStr = _dateRegexp.stringMatch(string);
        if (dateStr != null) {
          try {
            startDate = _dateFormatter.parseStrict(dateStr);
            string = string.removePrefix(_dateLength);
            // ignore: empty_catches
          } on FormatException {
            //just skip date's parsing
          }
        }
      }
      // ignore: empty_catches
    } on FormatException {
      //just skip date's parsing
    }
  }
  return (endDate, startDate, string);
}

List<String> _parseProjects(String string) => _parseWithRegexp(
      string,
      _projectRegexp,
    );

List<String> _parseContexts(String string) => _parseWithRegexp(
      string,
      _contextRegexp,
    );

List<String> _parseWithRegexp(String string, RegExp regExp) {
  Iterable<RegExpMatch> matches = regExp.allMatches(string);
  // TODO: should we check e[0] == null and use removeWhere? add catch and logs
  return matches.map((e) => e[0]!.substring(2)).toList();
}

const _completionMark = 'x ';
const _completionMarkLength = _completionMark.length;
const _priorityMarks = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const _priorityMarkLength = '(A) '.length;

final _dateRegexp = RegExp(r'^\d\d\d\d-\d\d-\d\d ');
const _dateLength = '2023-11-17 '.length;
final _dateFormatter = DateFormat('y-M-d ');

final _projectRegexp = RegExp(r' (\+\S+)');
final _contextRegexp = RegExp(r' (@\S+)');

extension StringEx on String {
  String removePrefix(int prefixLength) =>
      prefixLength >= length ? '' : substring(prefixLength);
}
