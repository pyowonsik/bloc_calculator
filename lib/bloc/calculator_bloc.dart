import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

// Bloc 구조
// Bloc 에서 이벤트를 통해 상태를 변경한다
// Bloc Provider를 통해 Bloc을 상속받은
// 뷰에서 메소드를 통해 파라미터가 들어오면 이벤트를 통해 스테이트속 상태를 변경
// Bloc Builder를 통해 데이터 사용

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
    on<CalculateEvent>(_calculate);
    on<InitEvent>(_init);
  }

  _inputNumber(InputNumberEvent event, emit) {
    emit(state.copyWith(input: event.input));
  }

  _calculate(CalculateEvent event, emit) {
    emit(state.copyWith(result: event.result));
  }

  _init(CalculatorEvent event, emit) {
    emit(state.copyWith(input: 0, result: 0));
  }
}
