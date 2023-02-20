import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
  }

  _inputNumber(InputNumberEvent event, emit) {
    emit(state.copyWith(result: event.num));
  }
}
