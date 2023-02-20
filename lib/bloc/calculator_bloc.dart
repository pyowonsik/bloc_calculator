import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';
import 'package:bloc_calculator/model/calculation_model.dart';

// Bloc 구조
// Bloc 에서 이벤트를 통해 상태를 변경한다
// Bloc Provider를 통해 Bloc을 상속받은
// 뷰에서 메소드를 통해 파라미터가 들어오면 이벤트를 통해 스테이트속 상태를 변경
// Bloc Builder를 통해 데이터 사용

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  dynamic lastNumber = '';

  CalculatorBloc() : super(CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
    on<CalculateEvent>(_calculate);
    on<InitEvent>(_init);
    // on<InputValues>(_inputValue);
  }

  _inputNumber(InputNumberEvent event, emit) async {
    lastNumber = lastNumber + event.input.toString();

    emit(state.copyWith(input: lastNumber));
  }

  _calculate(CalculateEvent event, emit) async {
    emit(state.copyWith(result: event.result));
  }

  _init(CalculatorEvent event, emit) async {
    lastNumber = '';
    emit(state.copyWith(input: 0, result: 0));
  }

  // _inputValue(InputValues event, emit) async {
  //   lastNum = lastNum + event.inputValue.toString();
  //   print(lastNum);
  //   emit(state.copyWith(calculationModel: CalculationModel(input: lastNum)));
  // }
}
