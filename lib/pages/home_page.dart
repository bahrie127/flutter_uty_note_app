import 'package:flutter/material.dart';
import 'package:flutter_uty_note_app/data/local_datasource/note_local_db.dart';
import 'package:flutter_uty_note_app/pages/add_form_page.dart';
import 'package:flutter_uty_note_app/pages/widgets/card_widget.dart';

import '../data/models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  bool isLoading = false;

  Future getAllNote() async {
    setState(() {
      isLoading = true;
    });
    notes = await NoteLocalDB().getAllNote();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Apps UTY'),
        centerTitle: true,
        elevation: 2,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : notes.isEmpty
              ? const Center(
                  child: Text(
                    'Notes Empty',
                    style: TextStyle(fontSize: 24),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return CardWidget(index: index, note: notes[index]);
                    },
                    itemCount: notes.length,
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddFormPage();
          }));
          getAllNote();
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
