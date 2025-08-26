import 'package:flutter/material.dart';
import 'package:flutter_workshop/user_api.dart';

/// - TODO: Add notes (FloatingActionButton)
/// - TODO: Edit note (TextField)
/// - TODO: (Optional) Delete note (Button, showDialog for confirm)
/// - TODO: (Optional) Save with shared_preferences
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
      body: FutureBuilder(
        future: UserApi().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].email),
                onTap: () => onClick(context, snapshot.data![index].id),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
      body: FutureBuilder(
        future: UserApi().getUser(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Id'),
                  subtitle: Text(snapshot.data!.id.toString()),
                ),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(snapshot.data!.name),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(snapshot.data!.email),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
