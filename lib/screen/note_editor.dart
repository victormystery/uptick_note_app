import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../style/app_style.dart';
import '../utils/database_helper.dart'; // Import your database helper
import '../model/note_model.dart'; // Import your Note model

class NoteEditorScreen extends StatefulWidget {
  final DatabaseHelper dbHelper; // Pass your dbHelper through the constructor
  final Note? note; // Pass your note through the constructor

  const NoteEditorScreen({Key? key, required this.dbHelper, this.note})
      : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
  String? title;
  String? desc;

  onClicked() async {
              save();
              Navigator.pop(context);
            }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add a New Note',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onClicked,
            icon: const Icon(Icons.check),
            color: AppStyle.accentColor,
            iconSize: 30,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (val) {
                title = val;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
              height: 28,
            ),
            TextFormField(
              onChanged: (val) {
                desc = val;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Description',
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
    );
  }

  void save() async {
    if (widget.note != null) {
      widget.note!.title = title!.trim();
      widget.note!.content = desc!.trim();

      await widget.dbHelper.update(widget.note!);

      Navigator.pop(context);
    } else {
      // Create a new note
      Note newNote = Note(
        id: 0, // Provide the correct ID or let the database handle it
        title: title!.trim(),
        content: desc!.trim(),
        creationDate: DateTime.now(),
        colorId: color_id, // You might want to set the correct color ID
      );

      await widget.dbHelper.insert(newNote);

      Navigator.pop(context);
    }
  }
}
