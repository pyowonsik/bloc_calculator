import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_state.freezed.dart';
part 'calculator_state.g.dart';

@freezed
class CalculatorState with _$CalculatorState {
  factory CalculatorState({
    required String inputExpression,
    required String resultExpression,
    required num calculatedNumber,
    required bool isCalculated,
  }) = _CalculatorState;

  factory CalculatorState.fromJson(Map<String, dynamic> json) =>
      _$CalculatorStateFromJson(json);
}
