import 'package:flutter/material.dart';
import 'package:mobdev_pel/data/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
      id: '1',
      title: 'Catatan Pertama',
      content: 'Ini adalah isi dari catatan pertama saya.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: '2',
      title: 'Catatan Kedua',
      content: 'Ini adalah isi dari catatan kedua saya.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  void addNote() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Catatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Isi'),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final newNote = Note(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  content: contentController.text,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                setState(() {
                  notes.add(newNote);
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void deleteNote(String id) {
    setState(() {
      notes.removeWhere((note) => note.id == id);
    });
  }

  void editNote(Note note) {
    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Catatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Isi'),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedNote = note.copyWith(
                  title: titleController.text,
                  content: contentController.text,
                  updatedAt: DateTime.now(),
                );
                setState(() {
                  final index = notes.indexWhere((n) => n.id == note.id);
                  if (index != -1) {
                    notes[index] = updatedNote;
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Harianku'),
        centerTitle: true,
        elevation: 4,
      ),
      body: 
      notes.isEmpty
      ? Center(
        child: Text(
          
        ),
      )
      
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Text(
                note.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  deleteNote(note.id);
                },
                icon: Icon(Icons.delete, color: Colors.redAccent),
              ),
              onTap: () {
                editNote(note);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addNote();
        },
        label: const Text('Tambah Catatan'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
