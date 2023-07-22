import 'package:flutter/material.dart';
import 'package:flutter_uty_note_app/data/local_datasource/note_local_db.dart';
import 'package:flutter_uty_note_app/data/models/note.dart';

class AddFormPage extends StatefulWidget {
  const AddFormPage({super.key});

  @override
  State<AddFormPage> createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Note note = Note(
                    title: titleController.text,
                    content: contentController.text,
                    createdTime: DateTime.now(),
                  );
                  NoteLocalDB().insertNote(note);
                  titleController.clear();
                  contentController.clear();
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.save)),
          const SizedBox(
            width: 16,
          ),
        ],
        elevation: 2,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: contentController,
                maxLines: 6,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Content',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
