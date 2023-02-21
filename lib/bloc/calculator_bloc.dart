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
  dynamic formula = '';
  dynamic formulaResult = 0;
  dynamic formulaList;
  dynamic operatorList = [];
  dynamic number = '';
  List<dynamic> numbers = [];
  List<String> operator = ['+', '-', '*', '/'];
  bool isNumber = false;

  //
  CalculatorBloc() : super(CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
    on<InitEvent>(_init);
    // on<InputValues>(_inputValue);
    // on<CalculateEvent>(_calculate);
  }

  _inputNumber(InputNumberEvent event, emit) async {
    // event.input == 숫자
    if (event.input.runtimeType == int) {
      number = number + event.input.toString();
      formula = formula + event.input.toString();
      emit(state.copyWith(input: formula));
      print('연산식 : $formula');
      isNumber = true;
    }

    // event.input == 연산자
    if (event.input == '+' ||
        event.input == '-' ||
        event.input == '*' ||
        event.input == '/') {
      //

      if (isNumber == true) {
        if (number != '') {
          numbers.add(number);
          number = '';
          //
          operatorList.add(event.input);
          isNumber = false;
          print('숫자 리스트 : $numbers');
          print('부호 리스트 : $operatorList');
          formula = formula + event.input.toString();
          emit(state.copyWith(input: formula));
          print('연산식 : $formula');
        }
      }

      if (isNumber == false) {
        formula = formula;
        emit(state.copyWith(input: formula));
        print('연산식 : $formula');
      }
      // if (numbers.last == '') {
      //   numbers.removeLast();
      //   operatorList.removeLast();
      // }
    }

    // event.input == 계산
    if (event.input == '=') {}
  }

  _init(CalculatorEvent event, emit) async {
    formula = '';
    emit(state.copyWith(input: 0, result: 0));
  }

  // _calculate(CalculateEvent event, emit) async {
  //   var result = formula + '=';
  //   emit(state.copyWith(result: result));
  // }

  // _inputValue(InputValues event, emit) async {
  //   lastNum = lastNum + event.inputValue.toString();
  //   print(lastNum);
  //   emit(state.copyWith(calculationModel: CalculationModel(input: lastNum)));
  // }
}
