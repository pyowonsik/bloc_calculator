import 'package:bloc_calculator/bloc/caculator_event.dart';
import 'package:bloc_calculator/bloc/calculator_bloc.dart';
import 'package:bloc_calculator/bloc/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCalculate = false;
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          // 삼항으로 계산버튼  눌리게 되면 보여주는식
          // (_isCalculate)
          //  ?
          BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
            return (isCalculate)
                ? Text(state.result.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold))
                : Container();
          }),
          // : Container(),

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
                        .add(InputNumberEvent(input: "1"));
                  },
                  child: const Text('1')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: "2"));
                  },
                  child: const Text('2')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: "3"));
                  },
                  child: const Text('3')),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CalculatorBloc>()
                        .add(InputNumberEvent(input: "+"));
                  },
                  child: const Text('+')),
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
              ElevatedButton(onPressed: () {}, child: const Text('0')),
              BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context
                          .read<CalculatorBloc>()
                          .add(CalculateEvent(result: state.input));
                      isCalculate = true;
                    },
                    child: const Text('='));
              }),
              ElevatedButton(onPressed: () {}, child: const Text('/')),
            ],
          ),
        ],
      ),
    );
  }
}
