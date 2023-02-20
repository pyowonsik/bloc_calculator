import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InputNumberEvent extends CalculatorEvent {
  final int num;
  InputNumberEvent({required this.num});
  @override
  List<Object> get props => [num];
}
