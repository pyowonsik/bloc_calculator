import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';
import 'package:flutter/material.dart';

import 'package:binary_tree/binary_tree.dart';

// Bloc 구조
// Bloc 에서 이벤트를 통해 상태를 변경한다
// Bloc Provider를 통해 Bloc을 상속받은
// 뷰에서 메소드를 통해 파라미터가 들어오면 이벤트를 통해 스테이트속 상태를 변경
// Bloc Builder를 통해 데이터 사용

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  dynamic formula = '';
  dynamic formulaResult = 0;
  dynamic operatorList = [];
  dynamic number = '';
  List<int> numbers = [];
  bool isNumber = false;

  //
  CalculatorBloc() : super(CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
    on<InitEvent>(_init);
  }

  _inputNumber(InputNumberEvent event, emit) async {
    // event.input == 숫자
    if (event.input.runtimeType == int) {
      number = number + event.input.toString();
      formula = formula + event.input.toString();
      // emit
      emit(state.copyWith(input: formula));
      print('연산식 : $formula');
      isNumber = true;
    }

    // event.input == 연산자
    if (event.input == '+' ||
        event.input == '-' ||
        event.input == '*' ||
        event.input == '/') {
      // 연산자 중복 입력 방지
      if (isNumber == true) {
        //
        numbers.add(int.parse(number));
        number = '';
        //
        operatorList.add(event.input.toString());
        isNumber = false;
        // emit
        formula = formula + event.input.toString();
        emit(state.copyWith(input: formula));
      }

      if (isNumber == false) {
        // emit
        formula = formula;
        emit(state.copyWith(input: formula));
      }
    }

    // event.input == 계산
    if (event.input == '=') {
      // 연산자 마무리 o

      if (isNumber == true) {
        numbers.add(int.parse(number));
        number = '';

        print(' -- 계산 시작 -- ');
        print('연산식 : $formula');
        print('숫자 리스트 : $numbers');
        print('부호 리스트 : $operatorList');

        // 트리
        print('-- 트리 --');
        var b = BinaryTree(numbers);
        print(b.toListFrom(0, equal: false, greaterThan: true));
        print(b);
        //
      }

      //
      // 연산자 마무리 x
      if (isNumber == false) {
        // emit
        formula = formula;
        emit(state.copyWith(input: formula));
      }
    }

    if (event.input == 'CE') {
      formula = formula.substring(0, formula.length - 1);
      // print(formula[formula.length - 1]);
      emit(state.copyWith(input: formula));
    }
  }

  _init(CalculatorEvent event, emit) async {
    formula = '';
    formulaResult = 0;
    operatorList = [];
    number = '';
    numbers = [];
    isNumber = true;
    emit(state.copyWith(input: 0, result: 0));
  }
}
