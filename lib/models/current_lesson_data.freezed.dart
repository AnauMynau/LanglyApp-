// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_lesson_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CurrentLessonData {
  List<Lesson> get currentLessons => throw _privateConstructorUsedError;
  List<String> get savedLessonIds => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrentLessonDataCopyWith<CurrentLessonData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentLessonDataCopyWith<$Res> {
  factory $CurrentLessonDataCopyWith(
          CurrentLessonData value, $Res Function(CurrentLessonData) then) =
      _$CurrentLessonDataCopyWithImpl<$Res, CurrentLessonData>;
  @useResult
  $Res call({List<Lesson> currentLessons, List<String> savedLessonIds});
}

/// @nodoc
class _$CurrentLessonDataCopyWithImpl<$Res, $Val extends CurrentLessonData>
    implements $CurrentLessonDataCopyWith<$Res> {
  _$CurrentLessonDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentLessons = null,
    Object? savedLessonIds = null,
  }) {
    return _then(_value.copyWith(
      currentLessons: null == currentLessons
          ? _value.currentLessons
          : currentLessons // ignore: cast_nullable_to_non_nullable
              as List<Lesson>,
      savedLessonIds: null == savedLessonIds
          ? _value.savedLessonIds
          : savedLessonIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentLessonDataImplCopyWith<$Res>
    implements $CurrentLessonDataCopyWith<$Res> {
  factory _$$CurrentLessonDataImplCopyWith(_$CurrentLessonDataImpl value,
          $Res Function(_$CurrentLessonDataImpl) then) =
      __$$CurrentLessonDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Lesson> currentLessons, List<String> savedLessonIds});
}

/// @nodoc
class __$$CurrentLessonDataImplCopyWithImpl<$Res>
    extends _$CurrentLessonDataCopyWithImpl<$Res, _$CurrentLessonDataImpl>
    implements _$$CurrentLessonDataImplCopyWith<$Res> {
  __$$CurrentLessonDataImplCopyWithImpl(_$CurrentLessonDataImpl _value,
      $Res Function(_$CurrentLessonDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentLessons = null,
    Object? savedLessonIds = null,
  }) {
    return _then(_$CurrentLessonDataImpl(
      currentLessons: null == currentLessons
          ? _value._currentLessons
          : currentLessons // ignore: cast_nullable_to_non_nullable
              as List<Lesson>,
      savedLessonIds: null == savedLessonIds
          ? _value._savedLessonIds
          : savedLessonIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$CurrentLessonDataImpl
    with DiagnosticableTreeMixin
    implements _CurrentLessonData {
  const _$CurrentLessonDataImpl(
      {final List<Lesson> currentLessons = const <Lesson>[],
      final List<String> savedLessonIds = const <String>[]})
      : _currentLessons = currentLessons,
        _savedLessonIds = savedLessonIds;

  final List<Lesson> _currentLessons;
  @override
  @JsonKey()
  List<Lesson> get currentLessons {
    if (_currentLessons is EqualUnmodifiableListView) return _currentLessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentLessons);
  }

  final List<String> _savedLessonIds;
  @override
  @JsonKey()
  List<String> get savedLessonIds {
    if (_savedLessonIds is EqualUnmodifiableListView) return _savedLessonIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedLessonIds);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CurrentLessonData(currentLessons: $currentLessons, savedLessonIds: $savedLessonIds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CurrentLessonData'))
      ..add(DiagnosticsProperty('currentLessons', currentLessons))
      ..add(DiagnosticsProperty('savedLessonIds', savedLessonIds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentLessonDataImpl &&
            const DeepCollectionEquality()
                .equals(other._currentLessons, _currentLessons) &&
            const DeepCollectionEquality()
                .equals(other._savedLessonIds, _savedLessonIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_currentLessons),
      const DeepCollectionEquality().hash(_savedLessonIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentLessonDataImplCopyWith<_$CurrentLessonDataImpl> get copyWith =>
      __$$CurrentLessonDataImplCopyWithImpl<_$CurrentLessonDataImpl>(
          this, _$identity);
}

abstract class _CurrentLessonData implements CurrentLessonData {
  const factory _CurrentLessonData(
      {final List<Lesson> currentLessons,
      final List<String> savedLessonIds}) = _$CurrentLessonDataImpl;

  @override
  List<Lesson> get currentLessons;
  @override
  List<String> get savedLessonIds;
  @override
  @JsonKey(ignore: true)
  _$$CurrentLessonDataImplCopyWith<_$CurrentLessonDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
