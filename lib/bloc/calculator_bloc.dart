import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  bool isNumber = false;
  bool isCalculated = false;
  List<String> operator = ['+', '-', '*', '/'];

  CalculatorBloc() : super(const CalculatorState.init()) {
    on<NumberPressed>(
      (NumberPressed event, emit) {
        if (!isCalculated) {
          if (state.input == '0') {
            emit(state.copyWith(input: ''));
          }
          emit(state.copyWith(input: state.input + event.number.toString()));
        }
        if (isCalculated) {
          if (event.number == 0) {
            emit(state.copyWith(
                input: '', result: state.calculateResultNumber.toString()));
            isCalculated = false;
          }
          emit(state.copyWith(input: event.number.toString()));
        }
        isNumber = true;
      },
    );
    on<OperatorPressed>((OperatorPressed event, emit) {
      if (isNumber) {
        emit(state.copyWith(input: state.input + event.operator));
        isNumber = false;
        isCalculated = false;
      }
    });

    on<CalculatePressed>(
      (CalculatePressed event, emit) {
        List<num> numbers = [];
        List<String> operatorList = [];
        List<dynamic> postfix = [];
        num resultNumber = 0;

        // 중위 표기식
        getInitFixExpression(numbers, operatorList);
        // 후위 표기식 변환
        postfix = getPostFixExpression(numbers, operatorList);
        // 후위 표기식 계산
        resultNumber = getPostFixCalculateResult(postfix);
        print(resultNumber);

        emit(state.copyWith(
            input: resultNumber.toString(),
            result: state.input,
            calculateResultNumber: resultNumber));
      },
    );

    on<RemovePressed>(
      (RemovePressed event, emit) {
        if (isCalculated) {
          emit(state.copyWith(
              input: '0', result: state.calculateResultNumber.toString()));
          isCalculated = false;
          isNumber = true;
        }
        if (state.input != '') {
          emit(state.copyWith(
              input: state.input.substring(0, state.input.length - 1)));
        }

        if (state.input == '') {
          emit(state.copyWith(input: '0'));
        }
      },
    );
  }

  void getInitFixExpression(List<num> numbers, List<String> operatorList) {
    String number = '';
    for (var i = 0; i < state.input.length; i++) {
      number += state.input[i].toString();
      if (operator.contains(state.input[i])) {
        operatorList.add(state.input[i]);
        number = number.substring(0, number.length - 1);
        numbers.add(double.parse(number));
        number = '';
      }
    }
    numbers.add(double.parse(number));
  }

  List getPostFixExpression(List<num> numbers, List<String> operatorList) {
    List<dynamic> postfix = [];
    List<String> sstack = [];
    String findDuplication = '';
    operatorList.add('');
    for (var i = 0; i < numbers.length; i++) {
      postfix.add(numbers[i]);
      if (sstack.isEmpty) {
        sstack.add(operatorList[i]);
      } else {
        if (operatorList[i] == '*' || operatorList[i] == '/') {
          if (sstack.contains('*') || sstack.contains('/')) {
            findDuplication = sstack.removeLast();
            postfix.add(findDuplication);
            sstack.add(operatorList[i]);
          }
          if (sstack.contains('+') || sstack.contains('-')) {
            sstack.add(operatorList[i]);
          } else {
            postfix.addAll(List.from(sstack.reversed));
            sstack.clear();
            sstack.add(operatorList[i]);
          }
        }

        if (operatorList[i] == '+' || operatorList[i] == '-') {
          if (sstack.any((e) => operator.contains(e))) {
            postfix.addAll(List.from(sstack.reversed));
            sstack.clear();
            sstack.add(operatorList[i]);
          }
        }
      }
    }

    postfix.addAll(List.from(sstack.reversed));
    sstack.clear();

    return postfix;
  }

  num getPostFixCalculateResult(List<dynamic> postfix) {
    List<dynamic> resultStack = [];
    num firstNumber = 0;
    num lastNumber = 0;
    for (var i = 0; i < postfix.length; i++) {
      if (!(postfix[i] == '+' ||
          postfix[i] == '-' ||
          postfix[i] == '*' ||
          postfix[i] == '/')) {
        resultStack.add(postfix[i]);
      }

      switch (postfix[i]) {
        case '+':
          firstNumber = resultStack.removeLast();
          lastNumber = resultStack.removeLast();
          resultStack.add(lastNumber + firstNumber);
          break;
        case '-':
          firstNumber = resultStack.removeLast();
          lastNumber = resultStack.removeLast();
          resultStack.add(lastNumber - firstNumber);
          break;
        case '*':
          firstNumber = resultStack.removeLast();
          lastNumber = resultStack.removeLast();
          resultStack.add(lastNumber * firstNumber);
          break;
        case '/':
          firstNumber = resultStack.removeLast();
          lastNumber = resultStack.removeLast();
          resultStack.add(lastNumber / firstNumber);
          break;
      }
    }
    isCalculated = true;
    return resultStack.removeLast();
  }
}
