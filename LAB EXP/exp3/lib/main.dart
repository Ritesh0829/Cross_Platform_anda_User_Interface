import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayText = "Welcome to Flutter!";
  String buttonText = "Change Text";

  void _changeText() {
    setState(() {
      if (displayText == "Welcome to Flutter!") {
        displayText = "Hello, World!";
        buttonText = "Reset Text";
      } else {
        displayText = "Welcome to Flutter!";
        buttonText = "Change Text";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              displayText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://picsum.photos/250?image=9',
              width: 300,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeText,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
