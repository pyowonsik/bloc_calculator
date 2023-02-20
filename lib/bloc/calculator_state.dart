import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final int result;

  const CalculatorState({
    required this.result,
  });

  const CalculatorState.init() : this(result: 0);

  CalculatorState copyWith({
    int? result,
  }) {
    return CalculatorState(result: result ?? this.result);
  }

  @override
  List<Object> get props => [result];
}
