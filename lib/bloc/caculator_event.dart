import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InputEvent extends CalculatorEvent {
  final String input;
  InputEvent({required this.input});
  @override
  List<Object> get props => [input];
}

class NumberPressed extends CalculatorEvent {
  final String number;
  NumberPressed({required this.number});
  @override
  List<Object> get props => [number];
}

class OperatorPressed extends CalculatorEvent {
  final String operator;
  OperatorPressed({required this.operator});
  @override
  List<Object> get props => [operator];
}

class CalculatePressed extends CalculatorEvent {
  @override
  List<Object> get props => [];
}

class RemovePressed extends CalculatorEvent {
  @override
  List<Object> get props => [];
}
