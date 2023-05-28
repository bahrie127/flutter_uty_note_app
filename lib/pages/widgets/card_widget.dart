import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_uty_note_app/common/constant.dart';
import 'package:flutter_uty_note_app/pages/detail_page.dart';
import 'package:intl/intl.dart';

import '../../data/models/note.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final Note note;
  const CardWidget({
    Key? key,
    required this.index,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = cardColors[Random().nextInt(10)];
    final time = DateFormat('dd-MM-yyyy hh:mm').format(note.createdTime);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPage(note: note);
        }));
      },
      child: Card(
        color: color,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                note.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
