import 'package:bloc_calculator/model/calculation_model.dart';
import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final dynamic input;
  final dynamic result;
  // final CalculationModel calculationModel;

  const CalculatorState({
    required this.input,
    required this.result,
    // required this.calculationModel
  });

  CalculatorState.init()
      : this(
          input: 0,
          result: 0,
          // calculationModel:
          //     CalculationModel(input: 0, operator: null, result: 0),
        );

  CalculatorState copyWith({
    dynamic result,
    dynamic input,
    // CalculationModel? calculationModel
  }) {
    return CalculatorState(
      input: input ?? this.input,
      result: result ?? this.result,
      // calculationModel: calculationModel ?? this.calculationModel
    );
  }

  @override
  List<Object> get props => [input, result];
}
