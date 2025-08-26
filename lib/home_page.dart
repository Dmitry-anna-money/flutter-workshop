import 'package:flutter/material.dart';
import 'package:flutter_workshop/note_repository.dart';

class HomePage extends StatefulWidget {
  final NoteRepository noteRepository;

  const HomePage(this.noteRepository, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder(
        future: Future.value(widget.noteRepository.getAll()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final note = snapshot.data![index];
                return ListTile(
                  title: Text(note.text.isNotEmpty ? note.text : 'No content'),
                  onTap: () => openNote(context, note.id),
                );
              },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => create(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void openNote(BuildContext context, int id) async {
    await Navigator.pushNamed(context, '/details', arguments: id);
    setState(() {});
  }

  void create(BuildContext context) async {
    final note = widget.noteRepository.create();
    await Navigator.pushNamed(context, '/details', arguments: note.id);
    setState(() {});
  }
}
