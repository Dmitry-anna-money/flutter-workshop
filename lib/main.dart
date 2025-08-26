import 'package:flutter/material.dart';
import 'package:flutter_workshop/details_page.dart';
import 'package:flutter_workshop/home_page.dart';
import 'package:flutter_workshop/note_repository.dart';

void main() {
  final noteRepository = NoteRepository();
  runApp(App(noteRepository));
}

class App extends StatelessWidget {
  final NoteRepository noteRepository;

  const App(this.noteRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      onGenerateRoute: (settings) => switch (settings.name) {
        '/home' => MaterialPageRoute(builder: (context) => HomePage(noteRepository)),
        '/details' => MaterialPageRoute(builder: (context) => DetailsPage(noteRepository, settings.arguments as int)),
        _ => null,
      },
    );
  }
}
