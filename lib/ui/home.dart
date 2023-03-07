import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_bloc.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> operators = ['+', '-', '*', '/'];
List<String> keypads = [
  '7',
  '8',
  '9',
  '/',
  '4',
  '5',
  '6',
  '*',
  '1',
  '2',
  '3',
  '-',
  '0',
  '=',
  'CE',
  '+',
];

bool isNumber(String keypad) => numbers.contains(keypad) ? true : false;

bool isOperator(String keypad) {
  if (operators.contains(keypad)) {
    return true;
  }
  return false;
}

bool isCalculate(String keypad) {
  if (keypad == '=') {
    return true;
  }
  return false;
}

bool isRemove(String keypad) {
  if (keypad == 'CE') {
    return true;
  }
  return false;
}

CalculatorEvent getEvent(String keypad) {
  if (isNumber(keypad)) {
    return NumberPressed(number: keypad);
  }
  if (isOperator(keypad)) {
    return OperatorPressed(operator: keypad);
  }
  if (isCalculate(keypad)) {
    return CalculatePressed();
  }
  if (isRemove(keypad)) {
    return RemovePressed();
  }
  return NumberPressed(number: keypad);
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(state.resultExpression.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(state.inputExpression.toString(),
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  children: keypads
                      .map((keypad) => ElevatedButton(
                            onPressed: () => context
                                .read<CalculatorBloc>()
                                .add(getEvent(keypad)),
                            child: Text(keypad),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
