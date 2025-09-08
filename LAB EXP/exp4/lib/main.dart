import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double _value1 = 0.0;
  double _value2 = 0.0;
  String _operation = "+";
  double _result = 0.0;
  bool _useSlider = false;

  void _calculate() {
    setState(() {
      switch (_operation) {
        case "+":
          _result = _value1 + _value2;
          break;
        case "-":
          _result = _value1 - _value2;
          break;
        case "*":
          _result = _value1 * _value2;
          break;
        case "/":
          if (_value2 != 0) {
            _result = _value1 / _value2;
          } else {
            _result = double.nan;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Advanced Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Use Sliders:"),
                Switch(
                  value: _useSlider,
                  onChanged: (value) {
                    setState(() {
                      _useSlider = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_useSlider) ...[
              Text("Value 1: ${_value1.toStringAsFixed(1)}"),
              Slider(
                value: _value1,
                min: 0,
                max: 100,
                divisions: 100,
                label: _value1.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _value1 = value;
                  });
                },
              ),
              Text("Value 2: ${_value2.toStringAsFixed(1)}"),
              Slider(
                value: _value2,
                min: 0,
                max: 100,
                divisions: 100,
                label: _value2.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _value2 = value;
                  });
                },
              ),
            ] else ...[
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Value 1",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _value1 = double.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Value 2",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _value2 = double.tryParse(value) ?? 0;
                  });
                },
              ),
            ],
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _operation,
              onChanged: (String? newValue) {
                setState(() {
                  _operation = newValue!;
                });
              },
              items: <String>['+', '-', '*', '/'].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, child: Text("Calculate")),
            SizedBox(height: 20),
            Text(
              "Result: $_result",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (_useSlider)
              LinearProgressIndicator(value: (_value1 + _value2) / 200),
          ],
        ),
      ),
    );
  }
}
