import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

const String initializedNumber = '0';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  List<String> operator = ['+', '-', '*', '/'];
  int get expressionLength => state.inputExpression.length - 1;

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
      if (operator.contains(state.inputExpression[expressionLength])) {
        return emit(
          state.copyWith(
            isCalculated: false,
            inputExpression: state.inputExpression.toString().replaceRange(
                  expressionLength,
                  null,
                  event.operator.toString(),
                ),
          ),
        );
      }
      return emit(
        state.copyWith(
          inputExpression: state.inputExpression + event.operator,
          isCalculated: false,
        ),
      );
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
              inputExpression:
                  state.inputExpression.substring(0, expressionLength),
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
    return RegExp(r'\d+')
        .allMatches(inputExpression)
        .map((e) => double.parse(e[0]!))
        .toList();
  }

  List<String> getOperatorFromExpression(String inputExpression) {
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
    for (var i = 0; i < postfix.length; i++) {
      if (!operator.contains(postfix[i])) {
        resultStack.add(postfix[i]);
      } else {
        double operand1 = resultStack.removeLast();
        double operand2 = resultStack.removeLast();
        switch (postfix[i]) {
          case '+':
            resultStack.add(operand2 + operand1);
            break;
          case '-':
            resultStack.add(operand2 - operand1);
            break;
          case '*':
            resultStack.add(operand2 * operand1);
            break;
          case '/':
            resultStack.add(operand2 / operand1);
            break;
        }
      }
    }
    return resultStack.removeLast();
  }
}
