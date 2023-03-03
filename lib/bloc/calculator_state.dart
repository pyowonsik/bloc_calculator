import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final String input;
  final String result;
  final num calculateResultNumber;
  final bool isCalculated;
  const CalculatorState({
    required this.input,
    required this.result,
    required this.calculateResultNumber,
    required this.isCalculated,
  });

  const CalculatorState.init()
      : this(
          input: '0',
          result: '0',
          calculateResultNumber: 0,
          isCalculated: false,
        );

  CalculatorState copyWith({
    String? input,
    String? result,
    num? calculateResultNumber,
    bool? isCalculated,
  }) {
    return CalculatorState(
      input: input ?? this.input,
      result: result ?? this.result,
      calculateResultNumber:
          calculateResultNumber ?? this.calculateResultNumber,
      isCalculated: isCalculated ?? this.isCalculated,
    );
  }

  @override
  List<Object> get props => [input, result];
}
