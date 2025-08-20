import 'package:flutter/material.dart';

/// TODO: Add the http package.
/// TODO: Fetch JSON from a REST API (e.g. JSONPlaceholder).
/// TODO: Parse into Dart models.
/// TODO: Display data in a list.
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      onGenerateRoute: (settings) => switch (settings.name) {
        '/home' => MaterialPageRoute(builder: (context) => const HomePage()),
        '/details' => MaterialPageRoute(builder: (context) => DetailsPage(settings.arguments as int)),
        _ => null,
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
          subtitle: Text('Click to view details'),
          onTap: () => onClick(context, index),
        ),
      ),
    );
  }

  void onClick(BuildContext context, int id) {
    Navigator.pushNamed(context, '/details', arguments: id);
  }
}

class DetailsPage extends StatelessWidget {
  final int id;

  const DetailsPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Text('Item $id'),
      ),
    );
  }
}
