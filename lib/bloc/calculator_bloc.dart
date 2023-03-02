import 'package:bloc/bloc.dart';
import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String formula = '';
  bool isNumber = false;
  bool isCalculated = false;
  List<String> operator = ['+', '-', '*', '/'];
  num resultNumber = 0;

  CalculatorBloc() : super(const CalculatorState.init()) {
    on<NumberPressed>(
      (NumberPressed event, emit) {
        bool isCalculated = false;
        if (!isCalculated) {
          emit(state.copyWith(input: formula += event.number.toString()));

          isNumber = true;
        }
      },
    );
    on<OperatorPressed>((OperatorPressed event, emit) {
      if (isNumber) {
        // number 자르기
        emit(state.copyWith(input: formula += event.operator));
        isNumber = false;
      }
      if (formula == '') {
        emit(state.copyWith(input: formula = '0'));
      }
      emit(state.copyWith(input: formula));
    });

    on<CalculatePressed>(
      (CalculatePressed event, emit) {
        String number = '';
        List<num> numbers = [];
        List<String> operatorList = [];
        List<dynamic> postfix = [];
        List<String> sstack = [];
        List<dynamic> resultStack = [];
        String findDuplication = '';

        // 식 전체를 받아서 중위 표기식 토큰화
        for (var i = 0; i < formula.length; i++) {
          number += formula[i].toString();
          if (operator.contains(formula[i])) {
            operatorList.add(formula[i]);
            number = number.substring(0, number.length - 1);
            numbers.add(double.parse(number));
            number = '';
          }
        }
        numbers.add(double.parse(number));

        // 후위 표기식
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
              // stack 리스트 자체적으로 돌면서 operator에 포함되는지 확인
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

        print('중위 : $formula');
        print('후위 : $postfix');
        // 후위 표기식 계산
        for (var i = 0; i < postfix.length; i++) {
          if (!(postfix[i] == '+' ||
              postfix[i] == '-' ||
              postfix[i] == '*' ||
              postfix[i] == '/')) {
            resultStack.add(postfix[i]);
          }

          switch (postfix[i]) {
            case '+':
              num firstNumber = resultStack.removeLast();
              num lastNumber = resultStack.removeLast();
              resultStack.add(lastNumber + firstNumber);
              break;
            case '-':
              num firstNumber = resultStack.removeLast();
              num lastNumber = resultStack.removeLast();
              resultStack.add(lastNumber - firstNumber);
              break;
            case '*':
              num firstNumber = resultStack.removeLast();
              num lastNumber = resultStack.removeLast();
              resultStack.add(lastNumber * firstNumber);
              break;
            case '/':
              num firstNumber = resultStack.removeLast();
              num lastNumber = resultStack.removeLast();
              resultStack.add(lastNumber / firstNumber);
              break;
          }
        }

        isCalculated = true;
        resultNumber = resultStack.removeLast();
        emit(state.copyWith(input: resultNumber, result: formula));
      },
    );

    on<RemovePressed>(
      (RemovePressed event, emit) {
        if (formula != '') {
          emit(state.copyWith(
              input: formula = formula.substring(0, formula.length - 1)));
        }
        if (isCalculated) {
          formula = '';
          emit(state.copyWith(input: 0, result: 'Ans = $resultNumber'));
        }
      },
    );
  }
}

//   _input(InputEvent event, emit) async {
//     // 계산 중
//     if (!isCalculated) {
//       // event.input == 숫자
//       if (event.input is num) {
//         // 식을 저장
//         formula = formula + event.input.toString();
//         number = number + event.input.toString();
//         emit(state.copyWith(input: formula));
//         isNumber = true;
//       }

//       // event.input == 연산자
//       if (operator.contains(event.input)) {
//         // 연산자 입력
//         if (isNumber) {
//           numbers.add(double.parse(number));
//           operatorList.add(event.input);
//           number = '';
//           isNumber = false;
//           formula = formula + event.input;
//           emit(state.copyWith(input: formula));
//         }
//         // 연산자 중복 입력시 변화 없음
//         if (!isNumber) {
//           formula = formula;
//           emit(state.copyWith(input: formula));
//         }
//       }

//       if (event.input == 'CE') {
//         if (formula[formula.length - 1] == '+' ||
//             formula[formula.length - 1] == '-' ||
//             formula[formula.length - 1] == '*' ||
//             formula[formula.length - 1] == '/') {
//           operatorList.removeLast();
//           isNumber = true;

//           if (number == '') {
//             number = numbers.removeLast().toString();
//           }
//         } else {
//           number = number.toString().substring(0, number.toString().length - 1);
//         }

//         formula = formula.substring(0, formula.length - 1);
//         emit(state.copyWith(input: formula));
//       }

//       // event.input == 계산
//       if (event.input == '=') {
//         // 숫자로 끝났을 경우 마지막 숫자 추가후 계산
//         if (isNumber) {
//           numbers.add(double.parse(number));
//           number = '';

//           // 중위 표기식 생성
//           operatorList.add(''); // 부호 숫자 인덱스 맞추기
//           for (var i = 0; i < numbers.length; i++) {
//             initfix.add(numbers[i]);
//             initfix.add(operatorList[i]);
//           }
//           initfix.removeLast();
//           operatorList.removeLast();

//           // 후위 표기식 변환
//           for (var i = 0; i < initfix.length; i++) {
//             // 피연산자
//             if (initfix[i] is num) {
//               postfix.add(initfix[i]);
//             }
//             // 연산자
//             if (operator.contains(initfix[i])) {
//               // 연산자 스택 Empty
//               if (sstack.isEmpty) {
//                 sstack.add(initfix[i]);
//               }
// any 사용
//               연산자 스택 !Empty
//               else {
//                 if (initfix[i] == '*' || initfix[i] == '/') {
//                   if (sstack.contains('*') || sstack.contains('/')) {
//                     if (sstack.contains('+') || sstack.contains('-')) {
//                       findDuplication = sstack.removeLast();
//                       postfix.add(findDuplication);
//                     } else {
//                       postfix.addAll(List.from(sstack.reversed));
//                       postfix.addAll(sstack);
//                       sstack.clear();
//                       sstack.add(initfix[i]);
//                     }
//                   }

//                   if (sstack.contains('+') || sstack.contains('-')) {
//                     sstack.add(initfix[i]);
//                   }
//                 }

//                 if (initfix[i] == '+' || initfix[i] == '-') {
//                   if (sstack.contains('+') ||
//                       sstack.contains('-') ||
//                       sstack.contains('*') ||
//                       sstack.contains('/')) {
//                     postfix.addAll(List.from(sstack.reversed));
//                     sstack.clear();
//                     sstack.add(initfix[i]);
//                   }
//                 }
//               }
//             }
//           }
//           postfix.addAll(List.from(sstack.reversed));
//           sstack.clear();

//           // 후위 표기식 계산
//           for (var i = 0; i < postfix.length; i++) {
//             if (postfix[i] is num) {
//               postfix.add(postfix[i]);
//             }
//             if (postfix[i] is String) {
//               postfix.add(postfix[i]);
//               calculatedNumber = caculate(postfix[i], postfix);
//             }
//           }
//           // 계산시
//           emit(state.copyWith(input: calculatedNumber));
//           formula += '=';
//           emit(state.copyWith(result: formula));
//           isCalculated = true;

//           numbers.clear();
//           numbers.add(calculatedNumber);
//           init();
//         }
//         // 연산자로 끝났을 경우 = 입력해도 변화 없음
//         if (!isNumber) {
//           formula = formula;
//           emit(state.copyWith(input: formula));
//         }
//       }
//     }

//     // 계산 완료
//     if (isCalculated) {
//       if (event.input is num) {
//         emit(state.copyWith(input: event.input, result: calculatedNumber));
//         numbers.clear();
//         formula = event.input.toString();
//         number += event.input.toString();
//         isCalculated = false;
//       }
//       if (operator.contains(event.input)) {
//         isCalculated = false;
//         formula = calculatedNumber.toString() + event.input;
//         emit(state.copyWith(input: formula, result: calculatedNumber));
//         operatorList.add(event.input);
//       }
//       if (event.input == 0 || event.input == 'CE') {
//         emit(state.copyWith(input: 0, result: calculatedNumber));
//         numbers.clear();
//         formula = '';
//         isCalculated = false;
//         isNumber = false;
//       }
//     }
// //
//   }

//   _init(CalculatorEvent event, emit) async {
//     formula = '';
//     number = '';
//     numbers.clear();
//     init();
//     emit(state.copyWith(input: 0, result: 0));
//   }

//   void init() {
//     operatorList.clear();
//     initfix.clear();
//     postfix.clear();
//     postfix.clear();
//   }

//   num caculate(op, List postfix) {
//     postfix.removeLast();
//     num firstNumber = postfix.removeLast();
//     num lastNumber = postfix.removeLast();
//     switch (op) {
//       case '+':
//         postfix.add(lastNumber + firstNumber);
//         break;
//       case '-':
//         postfix.add(lastNumber - firstNumber);
//         break;
//       case '*':
//         postfix.add(lastNumber * firstNumber);
//         break;
//       case '/':
//         postfix.add(lastNumber / firstNumber);
//         break;
//     }
//     return postfix.removeLast();
//   }
// }
