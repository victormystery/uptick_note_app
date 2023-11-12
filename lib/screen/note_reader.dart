import 'package:flutter/material.dart';
import '../model/note_model.dart';
import '../style/app_style.dart';
import '../utils/database_helper.dart';

class NoteReaderScreen extends StatefulWidget {
  final Note note;

  NoteReaderScreen({required this.note, Key? key}) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late String title;
  late String desc;
  bool edit = false;
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    title = widget.note.title;
    desc = widget.note.content;
    dbHelper = DatabaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    int? colorId = widget.note.colorId;

    return Scaffold(
      backgroundColor:
          colorId != null ? AppStyle.cardsColor[colorId]! : Colors.white,
      floatingActionButton: edit
          ? FloatingActionButton(
              onPressed: save,
              child: Icon(Icons.check),
            )
          : null,
      appBar: AppBar(
        backgroundColor:
            colorId != null ? AppStyle.cardsColor[colorId]! : Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                edit = !edit;
              });
            },
            icon: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              showDeleteConfirmationDialog();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: buildNoteEditor(),
    );
  }

  Widget buildNoteEditor() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (value) {
              title = value;
            },
            initialValue: widget.note.title,
            enabled: edit,
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
            widget.note.creationDate
                .toString(), // Adjust based on your Note model
            style: AppStyle.dateTitle,
          ),
          const SizedBox(
            height: 28,
          ),
          TextFormField(
            onChanged: (val) {
              desc = val;
            },
            initialValue: widget.note.content,
            enabled: edit,
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
    );
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Note"),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                deleteNote();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void deleteNote() async {
    await dbHelper.delete(widget.note.id);
    Navigator.pop(context);
  }

  void save() async {
    widget.note.title = title.trim();
    widget.note.content = desc.trim();

    await dbHelper.update(widget.note);

    Navigator.pop(context);
  }
}
