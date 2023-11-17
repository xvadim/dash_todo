// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Task {
  int get id => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  DateTime? get completionDate => throw _privateConstructorUsedError;
  DateTime? get creationDate => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<String> get contexts => throw _privateConstructorUsedError;
  List<String> get projects => throw _privateConstructorUsedError;
  String get rawString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {int id,
      bool isCompleted,
      String priority,
      DateTime? completionDate,
      DateTime? creationDate,
      String text,
      List<String> contexts,
      List<String> projects,
      String rawString});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isCompleted = null,
    Object? priority = null,
    Object? completionDate = freezed,
    Object? creationDate = freezed,
    Object? text = null,
    Object? contexts = null,
    Object? projects = null,
    Object? rawString = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      completionDate: freezed == completionDate
          ? _value.completionDate
          : completionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      creationDate: freezed == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      contexts: null == contexts
          ? _value.contexts
          : contexts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rawString: null == rawString
          ? _value.rawString
          : rawString // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      bool isCompleted,
      String priority,
      DateTime? completionDate,
      DateTime? creationDate,
      String text,
      List<String> contexts,
      List<String> projects,
      String rawString});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isCompleted = null,
    Object? priority = null,
    Object? completionDate = freezed,
    Object? creationDate = freezed,
    Object? text = null,
    Object? contexts = null,
    Object? projects = null,
    Object? rawString = null,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      completionDate: freezed == completionDate
          ? _value.completionDate
          : completionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      creationDate: freezed == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      contexts: null == contexts
          ? _value._contexts
          : contexts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      projects: null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rawString: null == rawString
          ? _value.rawString
          : rawString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {required this.id,
      this.isCompleted = false,
      this.priority = '',
      this.completionDate,
      this.creationDate,
      required this.text,
      final List<String> contexts = const [],
      final List<String> projects = const [],
      this.rawString = ''})
      : _contexts = contexts,
        _projects = projects;

  @override
  final int id;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final String priority;
  @override
  final DateTime? completionDate;
  @override
  final DateTime? creationDate;
  @override
  final String text;
  final List<String> _contexts;
  @override
  @JsonKey()
  List<String> get contexts {
    if (_contexts is EqualUnmodifiableListView) return _contexts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contexts);
  }

  final List<String> _projects;
  @override
  @JsonKey()
  List<String> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  @JsonKey()
  final String rawString;

  @override
  String toString() {
    return 'Task(id: $id, isCompleted: $isCompleted, priority: $priority, completionDate: $completionDate, creationDate: $creationDate, text: $text, contexts: $contexts, projects: $projects, rawString: $rawString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.completionDate, completionDate) ||
                other.completionDate == completionDate) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._contexts, _contexts) &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.rawString, rawString) ||
                other.rawString == rawString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      isCompleted,
      priority,
      completionDate,
      creationDate,
      text,
      const DeepCollectionEquality().hash(_contexts),
      const DeepCollectionEquality().hash(_projects),
      rawString);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);
}

abstract class _Task implements Task {
  const factory _Task(
      {required final int id,
      final bool isCompleted,
      final String priority,
      final DateTime? completionDate,
      final DateTime? creationDate,
      required final String text,
      final List<String> contexts,
      final List<String> projects,
      final String rawString}) = _$TaskImpl;

  @override
  int get id;
  @override
  bool get isCompleted;
  @override
  String get priority;
  @override
  DateTime? get completionDate;
  @override
  DateTime? get creationDate;
  @override
  String get text;
  @override
  List<String> get contexts;
  @override
  List<String> get projects;
  @override
  String get rawString;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
