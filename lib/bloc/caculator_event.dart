abstract class CalculatorEvent {}

class InputEvent extends CalculatorEvent {
  final String input;
  InputEvent({required this.input});
}

class NumberPressed extends CalculatorEvent {
  final String number;
  NumberPressed({required this.number});
}

class OperatorPressed extends CalculatorEvent {
  final String operator;
  OperatorPressed({required this.operator});
}

class CalculatePressed extends CalculatorEvent {}

class RemovePressed extends CalculatorEvent {}
