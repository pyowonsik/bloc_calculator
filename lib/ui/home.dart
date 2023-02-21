import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_bloc.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:binary_tree/binary_tree.dart';

// develop 브랜치에서 다 가져와서 pr

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCalculate = false;

    printTree() {
      // 트리를 이용해 연산자들을 정렬하자 !!
      var b = BinaryTree([10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 14, 18]);

      b.insert(26);
      b.insert(27);
      b.remove(27);

      print(b.toListFrom(0, equal: false, greaterThan: true));

      return;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
            return (isCalculate)
                ? Text(state.result.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold))
                : Container();
          }),
          const SizedBox(height: 20),
          BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
            return Text(state.input.toString(),
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold));
          }),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 1));
                  },
                  child: const Text('1')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 2));
                  },
                  child: const Text('2')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 3));
                  },
                  child: const Text('3')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: '+'));
                  },
                  child: const Text('+')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 4));
                  },
                  child: const Text('4')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 5));
                  },
                  child: const Text('5')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 6));
                  },
                  child: const Text('6')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: '-'));
                  },
                  child: const Text('-')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 7));
                  },
                  child: const Text('7')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 8));
                  },
                  child: const Text('8')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 9));
                  },
                  child: const Text('9')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: '*'));
                  },
                  child: const Text('*')),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(onPressed: () {}, child: const Text('4')),
          //     ElevatedButton(onPressed: () {}, child: const Text('5')),
          //     ElevatedButton(onPressed: () {}, child: const Text('6')),
          //     ElevatedButton(onPressed: () {}, child: const Text('-')),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(onPressed: () {}, child: const Text('7')),
          //     ElevatedButton(onPressed: () {}, child: const Text('8')),
          //     ElevatedButton(onPressed: () {}, child: const Text('9')),
          //     ElevatedButton(onPressed: () {}, child: const Text('*')),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<CalculatorBloc>().add(InitEvent());
                    isCalculate = false;
                  },
                  child: const Text('AC')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: 0));
                  },
                  child: const Text('0')),
              BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context
                          //     .read<CalculatorBloc>()
                          //     .add(CalculateEvent(result: state.input));
                          .read<CalculatorBloc>()
                          .add(InputNumberEvent(input: '='));
                      isCalculate = true;
                    },
                    child: const Text('='));
              }),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: '/'));
                  },
                  child: const Text('/')),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                context
                    .read<CalculatorBloc>()
                    .add(InputNumberEvent(input: 'CE'));
              },
              child: const Text('CE')),
          ElevatedButton(
              onPressed: () {
                printTree();
              },
              child: const Text('Tree')),
        ],
      ),
    );
  }
}
