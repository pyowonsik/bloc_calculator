import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';
import 'package:flutter/material.dart';

// Bloc 구조
// Bloc 에서 이벤트를 통해 상태를 변경한다
// Bloc Provider를 통해 Bloc을 상속받은
// 뷰에서 메소드를 통해 파라미터가 들어오면 이벤트를 통해 스테이트속 상태를 변경
// Bloc Builder를 통해 데이터 사용

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  dynamic formula = '';
  List<String> operatorList = [];
  dynamic number = '';
  List<num> numbers = [];
  bool isNumber = false;
  List<String> operator = ['+', '-', '*', '/'];

  List<dynamic> initfix = [];
  List<dynamic> postfix = [];
  List<String> sstack = [];
  String? findDuplication;

  List<dynamic> resultStack = [];

  num firstNumber = 0;
  num lastNumber = 0;
  num calculatedNumber = 0;
  bool isCalculated = false;

  CalculatorBloc() : super(CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
    on<InitEvent>(_init);
  }

  _inputNumber(InputNumberEvent event, emit) async {
    print('연산식 : $formula');
    print(' ---------- result ----------');
    print('formula : $formula');
    print('numbers : $numbers');
    print('operatorList : $operatorList');
    print('initfix : $initfix');
    print('postfix : $postfix');
    print('resultStack : $resultStack');
    print(' ---------- e n d ----------');
    // 계산 중
    if (!isCalculated) {
      // event.input == 숫자
      if (event.input is num) {
        // 식을 저장
        formula = formula + event.input.toString();
        number = number + event.input.toString();
        emit(state.copyWith(input: formula));
        isNumber = true;
      }

      // event.input == 연산자
      if (operator.contains(event.input)) {
        // 연산자 입력
        if (isNumber) {
          numbers.add(double.parse(number));
          operatorList.add(event.input);
          number = '';
          isNumber = false;
          formula = formula + event.input;
          emit(state.copyWith(input: formula));
        }
        // 연산자 중복 입력시 변화 없음
        if (!isNumber) {
          formula = formula;
          emit(state.copyWith(input: formula));
        }
      }

      if (event.input == 'CE') {
        if (formula[formula.length - 1] == '+' ||
            formula[formula.length - 1] == '-' ||
            formula[formula.length - 1] == '*' ||
            formula[formula.length - 1] == '/') {
          operatorList.removeLast();
          isNumber = true;

          if (number == '') {
            number = numbers.removeLast().toString();
            print(number);
          }
        } else {
          number = number.toString().substring(0, number.toString().length - 1);
        }

        formula = formula.substring(0, formula.length - 1);
        emit(state.copyWith(input: formula));

        print(' ---------- result ----------');
        print('formula : $formula');
        print('number : $number');
        print('numbers : $numbers');
        print('operatorList : $operatorList');
        print('initfix : $initfix');
        print('postfix : $postfix');
        print('resultStack : $resultStack');

        print(' ---------- e n d ----------');
      }

      // event.input == 계산
      if (event.input == '=') {
        // 숫자로 끝났을 경우 마지막 숫자 추가후 계산
        if (isNumber) {
          numbers.add(double.parse(number));
          number = '';

          print(' -- 계산 시작 -- ');
          print('연산식 : $formula');
          print('숫자 리스트 : $numbers');
          print('부호 리스트 : $operatorList');

          // 중위 표기식 생성
          operatorList.add(''); // 부호 숫자 인덱스 맞추기
          for (var i = 0; i < numbers.length; i++) {
            initfix.add(numbers[i]);
            initfix.add(operatorList[i]);
          }
          initfix.removeLast();
          operatorList.removeLast();
          print('Initfix : $initfix');

          // 후위 표기식 변환
          for (var i = 0; i < initfix.length; i++) {
            // 피연산자
            if (initfix[i] is num) {
              postfix.add(initfix[i]);
            }
            // 연산자
            if (operator.contains(initfix[i])) {
              // 연산자 스택 Empty
              if (sstack.isEmpty) {
                sstack.add(initfix[i]);
              }
              // 연산자 스택 !Empty
              else {
                if (initfix[i] == '*' || initfix[i] == '/') {
                  if (sstack.contains('*') || sstack.contains('/')) {
                    if (sstack.contains('+') || sstack.contains('-')) {
                      findDuplication = sstack.removeLast();
                      postfix.add(findDuplication);
                    } else {
                      postfix.addAll(List.from(sstack.reversed));
                      postfix.addAll(sstack);
                      sstack.clear();
                      sstack.add(initfix[i]);
                    }
                  }

                  if (sstack.contains('+') || sstack.contains('-')) {
                    sstack.add(initfix[i]);
                  }
                }
                if (initfix[i] == '+' || initfix[i] == '-') {
                  if (sstack.contains('+') ||
                      sstack.contains('-') ||
                      sstack.contains('*') ||
                      sstack.contains('/')) {
                    postfix.addAll(List.from(sstack.reversed));
                    sstack.clear();
                    sstack.add(initfix[i]);
                  }
                }
              }
            }
          }
          postfix.addAll(List.from(sstack.reversed));
          print('Postfix : $postfix');
          sstack.clear();

          // 후위 표기식 계산
          for (var i = 0; i < postfix.length; i++) {
            if (postfix[i] is num) {
              resultStack.add(postfix[i]);
            }
            if (postfix[i] is String) {
              resultStack.add(postfix[i]);
              caculate(postfix[i], resultStack);
            }
          }

          // 계산시
          calculatedNumber = resultStack.elementAt(0);
          emit(state.copyWith(input: calculatedNumber));
          formula += '=';
          emit(state.copyWith(result: formula));
          isCalculated = true;
          print(' ---------- result ----------');
          print('formula : $formula');
          print('numbers : $numbers');
          print('operatorList : $operatorList');
          print('initfix : $initfix');
          print('postfix : $postfix');
          print('resultStack : $resultStack');
          numbers.clear();
          numbers.add(calculatedNumber);
          init();
          print(' ---------- e n d ----------');
        }

        // 연산자로 끝났을 경우 = 입력해도 변화 없음
        if (!isNumber) {
          formula = formula;
          emit(state.copyWith(input: formula));
        }
      }
    }

    // 계산 완료
    if (isCalculated) {
      if (event.input is num) {
        emit(state.copyWith(input: event.input, result: calculatedNumber));
        numbers.clear();
        formula = event.input.toString();
        number += event.input.toString();
        isCalculated = false;
      }
      if (event.input == '+' ||
          event.input == '-' ||
          event.input == '*' ||
          event.input == '/') {
        isCalculated = false;
        formula = calculatedNumber.toString() + event.input;
        emit(state.copyWith(input: formula, result: calculatedNumber));
        operatorList.add(event.input);
      }
      if (event.input == 0 || event.input == 'CE') {
        emit(state.copyWith(input: 0, result: calculatedNumber));
        numbers.clear();
        formula = '';
        isCalculated = false;
        isNumber = false;
      }
    }
//
  }

  _init(CalculatorEvent event, emit) async {
    formula = '';
    number = '';
    numbers.clear();
    init();
    emit(state.copyWith(input: 0, result: 0));
  }

  void init() {
    operatorList.clear();
    initfix.clear();
    resultStack.clear();
    postfix.clear();
  }

  void caculate(op, resultStack) {
    resultStack.removeLast();
    firstNumber = resultStack.removeLast();
    lastNumber = resultStack.removeLast();

    switch (op) {
      case '+':
        resultStack.add(lastNumber + firstNumber);
        break;
      case '-':
        resultStack.add(lastNumber - firstNumber);
        break;
      case '*':
        resultStack.add(lastNumber * firstNumber);
        break;
      case '/':
        resultStack.add(lastNumber / firstNumber);
        break;
    }
  }
}
