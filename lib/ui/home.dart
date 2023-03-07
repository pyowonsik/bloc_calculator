import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_bloc.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ['7','8','9','4','5','6','1','2','3'].map((e) => ElevatedButton(onPressed : NumberPressed(number: e.toString()), child: child))

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          BlocBuilder<CalculatorBloc, CalculatorState>(
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
              ],
            );
          }),

          // Expanded(child: GridView.count(crossAxisCount: 4,)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '7'));
                  },
                  child: const Text('7')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '8'));
                  },
                  child: const Text('8')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '9'));
                  },
                  child: const Text('9')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressed(operator: '/'));
                  },
                  child: const Text('/')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '4'));
                  },
                  child: const Text('4')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '5'));
                  },
                  child: const Text('5')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '6'));
                  },
                  child: const Text('6')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressed(operator: '*'));
                  },
                  child: const Text('*')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '1'));
                  },
                  child: const Text('1')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '2'));
                  },
                  child: const Text('2')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '3'));
                  },
                  child: const Text('3')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressed(operator: '-'));
                  },
                  child: const Text('-')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(NumberPressed(number: '0'));
                  },
                  child: const Text('0')),
              const SizedBox(width: 10),
              BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<CalculatorBloc>().add(CalculatePressed());
                    },
                    child: const Text('='));
              }),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context.read<CalculatorBloc>().add(RemovePressed());
                  },
                  child: const Text('CE')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(OperatorPressed(operator: '+'));
                  },
                  child: const Text('+')),
            ],
          ),
        ],
      ),
    );
  }
}
