import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InputNumberEvent extends CalculatorEvent {
  final dynamic input;
  InputNumberEvent({required this.input});
  @override
  List<Object> get props => [input];
}

class CalculateEvent extends CalculatorEvent {
  final dynamic result;
  CalculateEvent({required this.result});

  @override
  List<Object> get props => [result];
}

class InitEvent extends CalculatorEvent {
  @override
  List<Object> get props => [];
}
