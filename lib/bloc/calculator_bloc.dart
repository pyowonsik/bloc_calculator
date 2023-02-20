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
  dynamic formula = '';
  dynamic res = 0;

  // List<String> operator = ['+', '-', '*', '/'];
  CalculatorBloc() : super(CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
    on<CalculateEvent>(_calculate);
    on<InitEvent>(_init);
    // on<InputValues>(_inputValue);
  }

  _inputNumber(InputNumberEvent event, emit) async {
    formula = formula + event.input.toString();

    emit(state.copyWith(input: formula));

    if (event.input == '+') {
      dynamic result = formula.replaceAll(RegExp('[^0-9]'), "");

      result = int.parse(result);
      print(formula);
      var formulaList = formula.split('+');
      print(formulaList);

      print('-- 원소 출력 --');
      // print(formulaList[0]);
      // print(formulaList[1]);
      // print(formulaList[2]);

      print('-- 결과 출력 --');
      if (formulaList.length == 2) {
        result = int.parse(formulaList[0]);
      }
      if (formulaList.length == 3) {
        result = int.parse(formulaList[0]) + int.parse(formulaList[1]);
      }
      if (formulaList.length == 4) {
        result = int.parse(formulaList[0]) +
            int.parse(formulaList[1]) +
            int.parse(formulaList[2]);
      }
      res = result;
      // print(result);
      // formula = '';
    }

    if (event.input == '=') {
      res = formula + res.toString();
      emit(state.copyWith(result: res));
    }
  }

  _calculate(CalculateEvent event, emit) async {
    var result = formula + '=';
    emit(state.copyWith(result: result));
  }

  _init(CalculatorEvent event, emit) async {
    formula = '';
    emit(state.copyWith(input: 0, result: 0));
  }

  // _inputValue(InputValues event, emit) async {
  //   lastNum = lastNum + event.inputValue.toString();
  //   print(lastNum);
  //   emit(state.copyWith(calculationModel: CalculationModel(input: lastNum)));
  // }
}
