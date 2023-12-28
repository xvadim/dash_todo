// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TasksFilter {
  String? get project => throw _privateConstructorUsedError;
  String? get context => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TasksFilterCopyWith<TasksFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksFilterCopyWith<$Res> {
  factory $TasksFilterCopyWith(
          TasksFilter value, $Res Function(TasksFilter) then) =
      _$TasksFilterCopyWithImpl<$Res, TasksFilter>;
  @useResult
  $Res call({String? project, String? context});
}

/// @nodoc
class _$TasksFilterCopyWithImpl<$Res, $Val extends TasksFilter>
    implements $TasksFilterCopyWith<$Res> {
  _$TasksFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = freezed,
    Object? context = freezed,
  }) {
    return _then(_value.copyWith(
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as String?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TasksFilterImplCopyWith<$Res>
    implements $TasksFilterCopyWith<$Res> {
  factory _$$TasksFilterImplCopyWith(
          _$TasksFilterImpl value, $Res Function(_$TasksFilterImpl) then) =
      __$$TasksFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? project, String? context});
}

/// @nodoc
class __$$TasksFilterImplCopyWithImpl<$Res>
    extends _$TasksFilterCopyWithImpl<$Res, _$TasksFilterImpl>
    implements _$$TasksFilterImplCopyWith<$Res> {
  __$$TasksFilterImplCopyWithImpl(
      _$TasksFilterImpl _value, $Res Function(_$TasksFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = freezed,
    Object? context = freezed,
  }) {
    return _then(_$TasksFilterImpl(
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as String?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TasksFilterImpl implements _TasksFilter {
  const _$TasksFilterImpl({this.project, this.context});

  @override
  final String? project;
  @override
  final String? context;

  @override
  String toString() {
    return 'TasksFilter(project: $project, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksFilterImpl &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, project, context);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksFilterImplCopyWith<_$TasksFilterImpl> get copyWith =>
      __$$TasksFilterImplCopyWithImpl<_$TasksFilterImpl>(this, _$identity);
}

abstract class _TasksFilter implements TasksFilter {
  const factory _TasksFilter({final String? project, final String? context}) =
      _$TasksFilterImpl;

  @override
  String? get project;
  @override
  String? get context;
  @override
  @JsonKey(ignore: true)
  _$$TasksFilterImplCopyWith<_$TasksFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
