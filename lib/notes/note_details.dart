import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/note.dart';
import 'package:notes/utils/colors.dart';
import 'package:provider/provider.dart';

import '../utils/routes.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context)?.settings.arguments as Note;

    Function deleteNote = Provider.of<NotesProvider>(context).deleteNote;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: IconButton(
                splashRadius: 25,
                onPressed: () async {
                  await _showDeleteDialog(context, deleteNote, note);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  size: 25,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                splashRadius: 25,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.createNote,
                      arguments: note);
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 25,
                )),
          ),
        ],
      ),
      backgroundColor: MyColors.background,
      body: Container(
        decoration: BoxDecoration(color: MyColors.tertiary.withOpacity(0.05)),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SelectableText(note.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: MyColors.secondary,
                )),
            Text(note.date.toUpperCase(),
                style: TextStyle(
                    fontSize: 14,
                    height: 1.8,
                    letterSpacing: 0.5,
                    color: Colors.black.withOpacity(0.8))),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: SelectableText(note.body,
                    style: const TextStyle(
                      fontSize: 17.5,
                      height: 1.7,
                      color: MyColors.primary,
                    ))),
          ],
        ),
      ),
    );
  }

  Future _showDeleteDialog(
      BuildContext context, Function deleteNote, Note note) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Note',
                style: TextStyle(color: MyColors.primary)),
            content: Text('Sure you want to delete "${note.title}"?',
                style: const TextStyle(color: MyColors.primary)),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  deleteNote(note.id);
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.home, (route) => false);
                },
              ),
            ],
          );
        });
  }
}
