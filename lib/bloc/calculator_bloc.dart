import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

const String initializedNumber = '0';

// Todo : 함수 쪼개기 , 매개변수로 inputExpression.state 넣어서 순수함수사용
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  List<String> operator = ['+', '-', '*', '/'];

  CalculatorBloc() : super(const CalculatorState.init()) {
    on<NumberPressed>(
      (NumberPressed event, emit) {
        if (!state.isCalculated) {
          if (state.inputExpression == initializedNumber) {
            emit(state.copyWith(inputExpression: ''));
          }
          emit(state.copyWith(
              inputExpression:
                  state.inputExpression + event.number.toString()));
        }
        if (state.isCalculated) {
          emit(
            state.copyWith(
              inputExpression: event.number.toString(),
              resultExpression: 'Ans = ${state.calculatedNumber.toString()}',
              isCalculated: false,
            ),
          );
        }
      },
    );
    on<OperatorPressed>((OperatorPressed event, emit) {
      if (operator
          .contains(state.inputExpression[state.inputExpression.length - 1])) {
        emit(
          state.copyWith(
            isCalculated: false,
            inputExpression: state.inputExpression.toString().replaceRange(
                  state.inputExpression.length - 1,
                  null,
                  event.operator.toString(),
                ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            inputExpression: state.inputExpression + event.operator,
            isCalculated: false,
          ),
        );
      }
    });

    on<CalculatePressed>(
      (CalculatePressed event, emit) {
        num resultNumber = 0;

        resultNumber = getPostFixCalculateResult(getPostFixExpression(
            getNumbersFromExpression(state.inputExpression),
            getOperatorFromExpression(state.inputExpression)));
        emit(
          state.copyWith(
            inputExpression: resultNumber.toString(),
            resultExpression: state.inputExpression,
            calculatedNumber: resultNumber,
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
                inputExpression: '0',
                resultExpression: 'Ans = ${state.calculatedNumber.toString()}'),
          );
        }
        if (state.inputExpression != '') {
          emit(
            state.copyWith(
              inputExpression: state.inputExpression
                  .substring(0, state.inputExpression.length - 1),
            ),
          );
        }
        if (state.inputExpression == '') {
          emit(state.copyWith(inputExpression: '0'));
        }
      },
    );
  }

  List<num> getNumbersFromExpression(String inputExpression) {
    // String number = '';
    // List<num> numbers = [];
    // for (var i = 0; i < inputExpression.length; i++) {
    //   number += inputExpression[i].toString();
    //   if (operator.contains(inputExpression[i])) {
    //     number = number.substring(0, number.length - 1);
    //     numbers.add(double.parse(number));
    //     number = '';
    //   }
    // }
    // numbers.add(double.parse(number));
    return RegExp(r'\d+')
        .allMatches(inputExpression)
        .map((e) => double.parse(e[0]!))
        .toList();
  }

  List<String> getOperatorFromExpression(String inputExpression) {
    // List<String> operatorList = [];
    // for (var i = 0; i < inputExpression.length; i++) {
    //   if (operator.contains(inputExpression[i])) operatorList.add(inputExpression[i]);
    // }
    // return operatorList;
    return inputExpression.split(RegExp(r'\d+')).where((e) => e != '').toList();
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
      if (!operator.contains(postfix[i])) {
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
