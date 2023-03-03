import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final String input;
  final String result;
  final num calculateResultNumber;

  const CalculatorState({
    required this.input,
    required this.result,
    required this.calculateResultNumber,
  });

  const CalculatorState.init()
      : this(
          input: '0',
          result: '0',
          calculateResultNumber: 0,
        );

  CalculatorState copyWith({
    String? input,
    String? result,
    num? calculateResultNumber,
  }) {
    return CalculatorState(
      input: input ?? this.input,
      result: result ?? this.result,
      calculateResultNumber:
          calculateResultNumber ?? this.calculateResultNumber,
    );
  }

  @override
  List<Object> get props => [input, result];
}
