import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final String inputExpression;
  final String resultExpression;
  final num calculatedNumber;
  final bool isCalculated;
  const CalculatorState({
    required this.inputExpression,
    required this.resultExpression,
    required this.calculatedNumber,
    required this.isCalculated,
  });

  const CalculatorState.init()
      : this(
          inputExpression: '0',
          resultExpression: '0',
          calculatedNumber: 0,
          isCalculated: false,
        );

  CalculatorState copyWith({
    String? inputExpression,
    String? resultExpression,
    num? calculatedNumber,
    bool? isCalculated,
  }) {
    return CalculatorState(
      inputExpression: inputExpression ?? this.inputExpression,
      resultExpression: resultExpression ?? this.resultExpression,
      calculatedNumber: calculatedNumber ?? this.calculatedNumber,
      isCalculated: isCalculated ?? this.isCalculated,
    );
  }

  @override
  List<Object> get props => [inputExpression, resultExpression];
}
