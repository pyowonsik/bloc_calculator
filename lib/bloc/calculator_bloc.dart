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
        if (!state.isCalculated && state.inputExpression == initializedNumber) {
          return emit(state.copyWith(inputExpression: '${event.number}'));
        }

        if (state.isCalculated) {
          return emit(
            state.copyWith(
              inputExpression: event.number.toString(),
              resultExpression: 'Ans = ${state.calculatedNumber.toString()}',
              isCalculated: false,
            ),
          );
        }
        return emit(state.copyWith(
            inputExpression: state.inputExpression + event.number.toString()));

        // if (!state.isCalculated && state.inputExpression == initializedNumber) {
        //   emit(state.copyWith(inputExpression: ''));
        // }
        // emit(state.copyWith(
        //     inputExpression: state.inputExpression + event.number.toString()));

        // if (state.isCalculated) {
        //   emit(
        //     state.copyWith(
        //       inputExpression: event.number.toString(),
        //       resultExpression: 'Ans = ${state.calculatedNumber.toString()}',
        //       isCalculated: false,
        //     ),
        //   );
        // }
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
                  state.inputExpression.substring(0, expressionLastIndex),
            ),
          );
        }

        if (state.inputExpression == '') {
          emit(state.copyWith(inputExpression: '0'));
        }
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
        // if (operatorList[i] == '*' || operatorList[i] == '/') {
        //   if (sstack.contains(operatorList[i])) {
        //     postfix.add(sstack.removeLast());
        //   }
        //   sstack.add(operatorList[i]);
        // }

        if (operatorList[i] == '*' || operatorList[i] == '/') {
          // 우선순위 같음
          if (sstack.contains('*') || sstack.contains('/')) {
            postfix.add(sstack.removeLast());
            sstack.add(operatorList[i]);
            print('sstack : $sstack');
          }

          // 우선순위 낮음
          if (sstack.contains('+') || sstack.contains('-')) {
            sstack.add(operatorList[i]);
            print('sstack : $sstack');
          }
        }

        if ((operatorList[i] == '+' || operatorList[i] == '-') &&
            sstack.any((e) => operator.contains(e))) {
          postfix.addAll([...sstack.reversed]);
          sstack.clear();
          sstack.add(operatorList[i]);
        }
      }
    }

    return [...postfix, ...sstack.reversed];
  }

  num getPostFixCalculateResult(List<dynamic> postfix) {
    print(postfix);
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
