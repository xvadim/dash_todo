// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Todos {
  List<Task> get tasks => throw _privateConstructorUsedError;
  Set<String> get projects => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodosCopyWith<Todos> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodosCopyWith<$Res> {
  factory $TodosCopyWith(Todos value, $Res Function(Todos) then) =
      _$TodosCopyWithImpl<$Res, Todos>;
  @useResult
  $Res call({List<Task> tasks, Set<String> projects});
}

/// @nodoc
class _$TodosCopyWithImpl<$Res, $Val extends Todos>
    implements $TodosCopyWith<$Res> {
  _$TodosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? projects = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodosImplCopyWith<$Res> implements $TodosCopyWith<$Res> {
  factory _$$TodosImplCopyWith(
          _$TodosImpl value, $Res Function(_$TodosImpl) then) =
      __$$TodosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Task> tasks, Set<String> projects});
}

/// @nodoc
class __$$TodosImplCopyWithImpl<$Res>
    extends _$TodosCopyWithImpl<$Res, _$TodosImpl>
    implements _$$TodosImplCopyWith<$Res> {
  __$$TodosImplCopyWithImpl(
      _$TodosImpl _value, $Res Function(_$TodosImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? projects = null,
  }) {
    return _then(_$TodosImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      projects: null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _$TodosImpl implements _Todos {
  const _$TodosImpl(
      {required final List<Task> tasks, required final Set<String> projects})
      : _tasks = tasks,
        _projects = projects;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final Set<String> _projects;
  @override
  Set<String> get projects {
    if (_projects is EqualUnmodifiableSetView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_projects);
  }

  @override
  String toString() {
    return 'Todos(tasks: $tasks, projects: $projects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodosImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_projects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodosImplCopyWith<_$TodosImpl> get copyWith =>
      __$$TodosImplCopyWithImpl<_$TodosImpl>(this, _$identity);
}

abstract class _Todos implements Todos {
  const factory _Todos(
      {required final List<Task> tasks,
      required final Set<String> projects}) = _$TodosImpl;

  @override
  List<Task> get tasks;
  @override
  Set<String> get projects;
  @override
  @JsonKey(ignore: true)
  _$$TodosImplCopyWith<_$TodosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
