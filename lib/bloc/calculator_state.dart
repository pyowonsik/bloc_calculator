import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final dynamic input;
  final dynamic result;

  const CalculatorState({
    required this.input,
    required this.result,
  });

  const CalculatorState.init()
      : this(
          input: 0,
          result: 0,
        );

  CalculatorState copyWith({
    dynamic result,
    dynamic input,
  }) {
    return CalculatorState(
      input: input ?? this.input,
      result: result ?? this.result,
    );
  }

  @override
  List<Object> get props => [input, result];
}
