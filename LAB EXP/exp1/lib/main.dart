

import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = '';

  void _calculate(String operation) {
    double? num1 = double.tryParse(_num1Controller.text);
    double? num2 = double.tryParse(_num2Controller.text);

    if (num1 == null || num2 == null) {
      setState(() {
        _result = 'Invalid input! Please enter valid numbers.';
      });
      return;
    }

    double result;
    switch (operation) {
      case 'Add':
        result = num1 + num2;
        break;
      case 'Subtract':
        result = num1 - num2;
        break;
      case 'Multiply':
        result = num1 * num2;
        break;
      case 'Divide':
        if (num2 == 0) {
          setState(() {
            _result = 'Cannot divide by zero!';
          });
          return;
        }
        result = num1 / num2;
        break;
      default:
        return;
    }

    setState(() {
      _result = 'The result is $result';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _num1Controller,
              decoration: const InputDecoration(
                labelText: 'Enter the first number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _num2Controller,
              decoration: const InputDecoration(
                labelText: 'Enter the second number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate('Add'),
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('Subtract'),
                  child: const Text('Subtract'),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('Multiply'),
                  child: const Text('Multiply'),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('Divide'),
                  child: const Text('Divide'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}