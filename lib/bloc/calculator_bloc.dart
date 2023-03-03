import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

// Todo : 함수 쪼개기 , 매개변수로 input.state 넣어서 순수함수사용
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  List<String> operator = ['+', '-', '*', '/'];

  CalculatorBloc() : super(const CalculatorState.init()) {
    on<NumberPressed>(
      (NumberPressed event, emit) {
        if (!state.isCalculated) {
          if (state.input == '0') {
            emit(state.copyWith(input: ''));
          }
          emit(state.copyWith(input: state.input + event.number.toString()));
        }
        if (state.isCalculated) {
          if (event.number == 0) {
            emit(
              state.copyWith(
                input: '',
                result: 'Ans = ${state.calculateResultNumber.toString()}',
                isCalculated: false,
              ),
            );
          }

          emit(state.copyWith(
              input: event.number.toString(), isCalculated: false));
        }
      },
    );
    on<OperatorPressed>((OperatorPressed event, emit) {
      if (operator.contains(state.input[state.input.length - 1])) {
        emit(
          state.copyWith(
            isCalculated: false,
            input: state.input.toString().replaceRange(
                  state.input.length - 1,
                  null,
                  event.operator.toString(),
                ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            input: state.input + event.operator,
            isCalculated: false,
          ),
        );
      }
    });

    on<CalculatePressed>(
      (CalculatePressed event, emit) {
        List<dynamic> postfix = [];
        num resultNumber = 0;

        resultNumber = getPostFixCalculateResult(getPostFixExpression(
            getNumbersFromExpression(state.input),
            getOperatorFromExpression(state.input)));
        emit(
          state.copyWith(
            input: resultNumber.toString(),
            result: state.input,
            calculateResultNumber: resultNumber,
            isCalculated: true,
          ),
        );
      },
    );

    on<RemovePressed>(
      (RemovePressed event, emit) {
        if (state.isCalculated) {
          emit(
            state.copyWith(
                isCalculated: false,
                input: '0',
                result: 'Ans = ${state.calculateResultNumber.toString()}'),
          );
        }
        if (state.input != '') {
          emit(
            state.copyWith(
              input: state.input.substring(0, state.input.length - 1),
            ),
          );
        }
        if (state.input == '') {
          emit(state.copyWith(input: '0'));
        }
      },
    );
  }

  List<num> getNumbersFromExpression(String input) {
    String number = '';
    List<num> numbers = [];
    for (var i = 0; i < input.length; i++) {
      number += input[i].toString();
      if (operator.contains(input[i])) {
        number = number.substring(0, number.length - 1);
        numbers.add(double.parse(number));
        number = '';
      }
    }

    numbers.add(double.parse(number));
    return numbers;
  }

  List<String> getOperatorFromExpression(String input) {
    List<String> operatorList = [];
    for (var i = 0; i < input.length; i++) {
      if (operator.contains(input[i])) operatorList.add(input[i]);
    }
    return operatorList;
  }

  List<dynamic> getPostFixExpression(
      List<num> numbers, List<String> operatorList) {
    List<dynamic> postfix = [];
    List<String> sstack = [];
    operatorList.add('');
    for (var i = 0; i < numbers.length; i++) {
      postfix.add(numbers[i]);
      if (sstack.isEmpty) {
        sstack.add(operatorList[i]);
      } else {
        if (operatorList[i] == '*' || operatorList[i] == '/') {
          if (sstack.contains('*') || sstack.contains('/')) {
            sstack.removeLast();
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
    return resultStack.removeLast();
  }
}
