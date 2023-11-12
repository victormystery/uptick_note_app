import 'package:flutter/material.dart';

import '../model/note_model.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  NoteCard({
    required this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print("NoteCard: ${note.title}"); // Add this line for debugging
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              note.creationDate.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              note.content,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
