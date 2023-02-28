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
