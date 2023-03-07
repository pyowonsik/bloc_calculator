import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

const String initializedNumber = '0';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  List<String> operator = ['+', '-', '*', '/'];
  int get expressionLastIndex => state.inputExpression.length - 1;

  CalculatorBloc() : super(const CalculatorState.init()) {
    on<NumberPressed>(
      (NumberPressed event, emit) {
        if (state.isCalculated) {
          if (event.number == initializedNumber) {
            return emit(state.copyWith(
                inputExpression: event.number,
                resultExpression:
                    'Ans = ${state.calculatedNumber.toString()}'));
          }

          return emit(
            state.copyWith(
              inputExpression: event.number.toString(),
              isCalculated: false,
            ),
          );
        }

        if (state.inputExpression == initializedNumber) {
          return emit(state.copyWith(
              inputExpression: event.number, resultExpression: '0'));
        }

        return emit(state.copyWith(
            inputExpression: state.inputExpression + event.number.toString()));
      },
    );
    on<OperatorPressed>((OperatorPressed event, emit) {
      if (operator.contains(state.inputExpression[expressionLastIndex])) {
        return emit(
          state.copyWith(
            isCalculated: false,
            inputExpression: state.inputExpression.toString().replaceRange(
                  expressionLastIndex,
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
        num resultNumber = getPostFixCalculateResult(
          getPostFixExpression(
            getNumbersFromExpression(state.inputExpression),
            getOperatorFromExpression(state.inputExpression),
          ),
        );
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
          return emit(state.copyWith(
              isCalculated: false,
              inputExpression: '0',
              resultExpression: 'Ans = ${state.calculatedNumber.toString()}'));
        }
        if (state.inputExpression.length == 1) {
          return emit(state.copyWith(inputExpression: initializedNumber));
        }
        return emit(state.copyWith(
          inputExpression:
              state.inputExpression.substring(0, expressionLastIndex),
        ));
      },
    );
  }

  List<num> getNumbersFromExpression(String inputExpression) => RegExp(r'\d+')
      .allMatches(inputExpression)
      .map((e) => double.parse(e[0]!))
      .toList();

  List<String> getOperatorFromExpression(String inputExpression) =>
      inputExpression.split(RegExp(r'\d+')).where((e) => e != '').toList();

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
          while (sstack.last == '*' || sstack.last == '/') {
            postfix.add(sstack.removeLast());
          }
          sstack.add(operatorList[i]);
        }
        if ((operatorList[i] == '+' || operatorList[i] == '-')) {
          postfix.addAll([...sstack.reversed]);
          sstack.clear();
          sstack.add(operatorList[i]);
        }
      }
    }

    return [...postfix, ...sstack.reversed];
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
