import 'package:flutter/material.dart';
import 'package:flutter_workshop/note_repository.dart';

class DetailsPage extends StatelessWidget {
  final NoteRepository noteRepository;
  final int id;
  final controller = TextEditingController();

  DetailsPage(this.noteRepository, this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: FutureBuilder(
        future: Future.value(noteRepository.getById(id)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                TextField(
                  controller: controller..text = snapshot.data!.text,
                  keyboardType: TextInputType.multiline,
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
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          FloatingActionButton(
            onPressed: () => delete(context),
            child: Text('Delete'),
          ),
          FloatingActionButton(
            onPressed: () => update(context),
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void update(BuildContext context) {
    noteRepository.update(id, controller.text);
    Navigator.pop(context);
  }

  void delete(BuildContext context) async {
    noteRepository.delete(id);
    final result = await showConfirmDialog(context);
    if (result == true) Navigator.pop(context);
  }

  Future<bool?> showConfirmDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete Note'),
      content: Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Delete'),
        ),
      ],
    ),
  );
}
