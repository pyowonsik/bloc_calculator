import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          const Text('0',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('0',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('1')),
              ElevatedButton(onPressed: () {}, child: const Text('2')),
              ElevatedButton(onPressed: () {}, child: const Text('3')),
              ElevatedButton(onPressed: () {}, child: const Text('/')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('4')),
              ElevatedButton(onPressed: () {}, child: const Text('5')),
              ElevatedButton(onPressed: () {}, child: const Text('6')),
              ElevatedButton(onPressed: () {}, child: const Text('*')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('7')),
              ElevatedButton(onPressed: () {}, child: const Text('8')),
              ElevatedButton(onPressed: () {}, child: const Text('9')),
              ElevatedButton(onPressed: () {}, child: const Text('-')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('AC')),
              ElevatedButton(onPressed: () {}, child: const Text('0')),
              ElevatedButton(onPressed: () {}, child: const Text('=')),
              ElevatedButton(onPressed: () {}, child: const Text('+')),
            ],
          ),
        ],
      ),
    );
  }
}
