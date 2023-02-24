import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

// Bloc 구조
// Bloc 에서 이벤트를 통해 상태를 변경한다
// Bloc Provider를 통해 Bloc을 상속받은
// 뷰에서 메소드를 통해 파라미터가 들어오면 이벤트를 통해 스테이트속 상태를 변경
// Bloc Builder를 통해 데이터 사용

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String formula = '';
  dynamic formulaResult = 0;
  List<String> operatorList = [];
  dynamic number = '';
  List<int> numbers = [];
  bool isNumber = false;
  dynamic operator = ['+', '-', '*', '/'];

  List<dynamic> Initfix = [];
  List<dynamic> Postfix = [];
  List<String> sstack = [];
  int result = 0;
  List<dynamic> reversedSstack = [];
  List<dynamic> resultStack = [];

  dynamic firstNumber = 0;
  dynamic lastNumber = 0;

  CalculatorBloc() : super(CalculatorState.init()) {
    on<InputNumberEvent>(_inputNumber);
    on<InitEvent>(_init);
  }

  _inputNumber(InputNumberEvent event, emit) async {
    // event.input == 숫자
    if (event.input.runtimeType == int) {
      // 식을 저장
      formula = formula + event.input.toString();

      number = number + event.input.toString();
      emit(state.copyWith(input: formula));
      print('연산식 : $formula');
      isNumber = true;
    }

    // event.input == 연산자
    if (operator.contains(event.input)) {
      // 연산자 입력
      if (isNumber) {
        numbers.add(int.parse(number));
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

    // event.input == 계산
    if (event.input == '=') {
      // 숫자로 끝났을 경우 마지막 숫자 추가후 계산
      if (isNumber) {
        numbers.add(int.parse(number));
        number = '';

        print(' -- 계산 시작 -- ');
        print('연산식 : $formula');
        print('숫자 리스트 : $numbers');
        print('부호 리스트 : $operatorList');

        // 중위 표기식 생성
        operatorList.add(''); // 부호 숫자 인덱스 맞춰줌
        for (var i = 0; i < numbers.length; i++) {
          Initfix.add(numbers[i]);
          Initfix.add(operatorList[i]);
        }
        Initfix.removeLast();
        operatorList.add('');
        print('Initfix : $Initfix');

        // 후위 표기식 변환
        for (var i = 0; i < Initfix.length; i++) {
          // 피연산자
          if (Initfix[i].runtimeType == int) {
            Postfix.add(Initfix[i]);
          }
          // 연산자
          if (operator.contains(Initfix[i])) {
            // 연산자 스택 Empty
            if (sstack.isEmpty) {
              sstack.add(Initfix[i]);
            }
            // 연산자 스택 !Empty
            else {
              if (Initfix[i] == '*' || Initfix[i] == '/') {
                if (sstack.contains('*') || sstack.contains('/')) {
                  if (sstack.contains('+') || sstack.contains('-')) {
                    dynamic findDuplication = sstack.removeLast();
                    Postfix.add(findDuplication);
                  } else {
                    List<dynamic> reversedSstack = List.from(sstack.reversed);
                    Postfix.addAll(reversedSstack);
                    Postfix.addAll(sstack);
                    sstack.clear();
                    sstack.add(Initfix[i]);
                  }
                }

                if (sstack.contains('+') || sstack.contains('-')) {
                  sstack.add(Initfix[i]);
                }
              }
              if (Initfix[i] == '+' || Initfix[i] == '-') {
                if (sstack.contains('+') ||
                    sstack.contains('-') ||
                    sstack.contains('*') ||
                    sstack.contains('/')) {
                  List<dynamic> reversedSstack = List.from(sstack.reversed);
                  Postfix.addAll(reversedSstack);
                  sstack.clear();
                  sstack.add(Initfix[i]);
                }
              }
            }
          }
        }
        reversedSstack = List.from(sstack.reversed);
        Postfix.addAll(reversedSstack);
        print('Postfix : $Postfix');

        sstack.clear();
        reversedSstack.clear();

        // 후위 표기식 계산
        for (var i = 0; i < Postfix.length; i++) {
          if (Postfix[i].runtimeType == int) {
            resultStack.add(Postfix[i]);
          }
          if (operatorList.contains(Postfix[i])) {
            resultStack.add(Postfix[i]);
            //
            if (Postfix[i] == '+') {
              resultStack.removeLast();
              firstNumber = resultStack.removeLast();
              lastNumber = resultStack.removeLast();
              result = lastNumber + firstNumber;
              resultStack.add(result);
              print('Stack : $resultStack');
            }
            if (Postfix[i] == '-') {
              resultStack.removeLast();
              firstNumber = resultStack.removeLast();
              lastNumber = resultStack.removeLast();
              result = lastNumber - firstNumber;
              resultStack.add(result);
              print('Stack : $resultStack');
            }
            if (Postfix[i] == '*') {
              resultStack.removeLast();
              firstNumber = resultStack.removeLast();
              lastNumber = resultStack.removeLast();
              result = lastNumber * firstNumber;
              resultStack.add(result);
              print('Stack : $resultStack');
            }
            if (Postfix[i] == '/') {
              resultStack.removeLast();
              firstNumber = resultStack.removeLast();
              lastNumber = resultStack.removeLast();
              result = lastNumber / firstNumber;
              resultStack.add(result);
              print('Stack : $resultStack');
            }
            //
          }
        }
        // print('정답 : ' + resultStack.removeLast().toString());
        emit(state.copyWith(input: resultStack.removeLast().toString()));
        emit(state.copyWith(result: formula));
      }
      //

      // 연산자로 끝났을 경우 = 입력해도 변화 없음
      if (!isNumber) {
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
