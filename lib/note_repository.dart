class NoteRepository {
  final List<Note> _notes = [];

  Note create() {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      text: '',
    );
    _notes.add(note);
    return note;
  }

  List<Note> getAll() => _notes;

  Note getById(int id) => _notes.firstWhere((note) => note.id == id);

  void update(int id, String text) {
    final index = _notes.indexWhere((note) => note.id == id);
    _notes[index] = Note(id: id, text: text);
  }

  void delete(int id) {
    _notes.removeWhere((note) => note.id == id);
  }
}

class Note {
  final int id;
  final String text;

  const Note({
    required this.id,
    required this.text,
  });
}
