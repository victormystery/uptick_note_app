import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/note_model.dart';
import '../style/app_style.dart';
import '../utils/database_helper.dart';
import '../widget/note_card.dart';
import 'note_editor.dart';
import 'note_reader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note>? notes;

  @override
  void initState() {
    super.initState();
    // Initialize your SQLite database and retrieve notes
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    notes = await DatabaseHelper.instance.getNotes();
    setState(() {});
  }

  void onAddNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NoteEditorScreen(dbHelper: DatabaseHelper.instance),
      ),
    ).then((_) {
      _loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Recent Notes',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: notes!.isEmpty ? emptyNote() : NoteListGrid(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddNote,
        label: Text('Take Note'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Center emptyNote() {
    return Center(
      child: Text(
        "No Note created yet",
        style: GoogleFonts.nunito(
          color: Colors.white,
        ),
      ),
    );
  }

  GridView NoteListGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: notes!.length,
      itemBuilder: (context, index) {
        var note = notes![index];
        return NoteCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteReaderScreen(note: note),
              ),
            );
          },
          note: note,
        );
      },
    );
  }
}
