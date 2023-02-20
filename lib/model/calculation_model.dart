import 'package:equatable/equatable.dart';

class CalculationModel extends Equatable {
  CalculationModel({
    this.input,
    this.result,
    this.operator,
  });

  final dynamic input;
  final dynamic result;
  final dynamic operator;
  @override
  List<Object?> get props => [input, result, operator];
}
