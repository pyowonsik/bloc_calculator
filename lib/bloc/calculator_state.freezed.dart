// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculator_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CalculatorState _$CalculatorStateFromJson(Map<String, dynamic> json) {
  return _CalculatorState.fromJson(json);
}

/// @nodoc
mixin _$CalculatorState {
  String get inputExpression => throw _privateConstructorUsedError;
  String get resultExpression => throw _privateConstructorUsedError;
  num get calculatedNumber => throw _privateConstructorUsedError;
  bool get isCalculated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalculatorStateCopyWith<CalculatorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculatorStateCopyWith<$Res> {
  factory $CalculatorStateCopyWith(
          CalculatorState value, $Res Function(CalculatorState) then) =
      _$CalculatorStateCopyWithImpl<$Res, CalculatorState>;
  @useResult
  $Res call(
      {String inputExpression,
      String resultExpression,
      num calculatedNumber,
      bool isCalculated});
}

/// @nodoc
class _$CalculatorStateCopyWithImpl<$Res, $Val extends CalculatorState>
    implements $CalculatorStateCopyWith<$Res> {
  _$CalculatorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputExpression = null,
    Object? resultExpression = null,
    Object? calculatedNumber = null,
    Object? isCalculated = null,
  }) {
    return _then(_value.copyWith(
      inputExpression: null == inputExpression
          ? _value.inputExpression
          : inputExpression // ignore: cast_nullable_to_non_nullable
              as String,
      resultExpression: null == resultExpression
          ? _value.resultExpression
          : resultExpression // ignore: cast_nullable_to_non_nullable
              as String,
      calculatedNumber: null == calculatedNumber
          ? _value.calculatedNumber
          : calculatedNumber // ignore: cast_nullable_to_non_nullable
              as num,
      isCalculated: null == isCalculated
          ? _value.isCalculated
          : isCalculated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CalculatorStateCopyWith<$Res>
    implements $CalculatorStateCopyWith<$Res> {
  factory _$$_CalculatorStateCopyWith(
          _$_CalculatorState value, $Res Function(_$_CalculatorState) then) =
      __$$_CalculatorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputExpression,
      String resultExpression,
      num calculatedNumber,
      bool isCalculated});
}

/// @nodoc
class __$$_CalculatorStateCopyWithImpl<$Res>
    extends _$CalculatorStateCopyWithImpl<$Res, _$_CalculatorState>
    implements _$$_CalculatorStateCopyWith<$Res> {
  __$$_CalculatorStateCopyWithImpl(
      _$_CalculatorState _value, $Res Function(_$_CalculatorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputExpression = null,
    Object? resultExpression = null,
    Object? calculatedNumber = null,
    Object? isCalculated = null,
  }) {
    return _then(_$_CalculatorState(
      inputExpression: null == inputExpression
          ? _value.inputExpression
          : inputExpression // ignore: cast_nullable_to_non_nullable
              as String,
      resultExpression: null == resultExpression
          ? _value.resultExpression
          : resultExpression // ignore: cast_nullable_to_non_nullable
              as String,
      calculatedNumber: null == calculatedNumber
          ? _value.calculatedNumber
          : calculatedNumber // ignore: cast_nullable_to_non_nullable
              as num,
      isCalculated: null == isCalculated
          ? _value.isCalculated
          : isCalculated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CalculatorState implements _CalculatorState {
  _$_CalculatorState(
      {required this.inputExpression,
      required this.resultExpression,
      required this.calculatedNumber,
      required this.isCalculated});

  factory _$_CalculatorState.fromJson(Map<String, dynamic> json) =>
      _$$_CalculatorStateFromJson(json);

  @override
  final String inputExpression;
  @override
  final String resultExpression;
  @override
  final num calculatedNumber;
  @override
  final bool isCalculated;

  @override
  String toString() {
    return 'CalculatorState(inputExpression: $inputExpression, resultExpression: $resultExpression, calculatedNumber: $calculatedNumber, isCalculated: $isCalculated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CalculatorState &&
            (identical(other.inputExpression, inputExpression) ||
                other.inputExpression == inputExpression) &&
            (identical(other.resultExpression, resultExpression) ||
                other.resultExpression == resultExpression) &&
            (identical(other.calculatedNumber, calculatedNumber) ||
                other.calculatedNumber == calculatedNumber) &&
            (identical(other.isCalculated, isCalculated) ||
                other.isCalculated == isCalculated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, inputExpression,
      resultExpression, calculatedNumber, isCalculated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CalculatorStateCopyWith<_$_CalculatorState> get copyWith =>
      __$$_CalculatorStateCopyWithImpl<_$_CalculatorState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CalculatorStateToJson(
      this,
    );
  }
}

abstract class _CalculatorState implements CalculatorState {
  factory _CalculatorState(
      {required final String inputExpression,
      required final String resultExpression,
      required final num calculatedNumber,
      required final bool isCalculated}) = _$_CalculatorState;

  factory _CalculatorState.fromJson(Map<String, dynamic> json) =
      _$_CalculatorState.fromJson;

  @override
  String get inputExpression;
  @override
  String get resultExpression;
  @override
  num get calculatedNumber;
  @override
  bool get isCalculated;
  @override
  @JsonKey(ignore: true)
  _$$_CalculatorStateCopyWith<_$_CalculatorState> get copyWith =>
      throw _privateConstructorUsedError;
}
