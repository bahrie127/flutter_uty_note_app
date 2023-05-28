import 'package:flutter/material.dart';
import 'package:flutter_uty_note_app/data/local_datasource/note_local_db.dart';
import 'package:flutter_uty_note_app/pages/edit_form_page.dart';
import 'package:flutter_uty_note_app/pages/home_page.dart';
import 'package:intl/intl.dart';

import '../data/models/note.dart';

class DetailPage extends StatelessWidget {
  final Note note;
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditFormPage(note: note);
              }));
            },
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Hapus Data'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Tidak')),
                        ElevatedButton(
                            onPressed: () {
                              NoteLocalDB().deleteNote(note.id!);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HomePage();
                              }));
                            },
                            child: const Text('Ya'))
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.delete_forever),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(DateFormat('dd-MM-yyyy hh:mm').format(note.createdTime)),
            const SizedBox(
              height: 16,
            ),
            Text(note.content),
          ],
        ),
      ),
    );
  }
}
