import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  String buttonText = 'Click me!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text('Hello, Flutter!'),
            ElevatedButton(
              onPressed: () => onClick(),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }

  void onClick() {
    setState(() {
      counter++;
      buttonText = 'Clicked! ($counter)';
    });
  }
}
