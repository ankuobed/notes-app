import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/note.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/routes.dart';
import 'package:provider/provider.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  String _title = '';
  String _body = '';

  @override
  Widget build(BuildContext context) {
    Note? note = ModalRoute.of(context)?.settings.arguments as Note?;

    Function addNote = Provider.of<NotesProvider>(context).addNote;
    Function editNote = Provider.of<NotesProvider>(context).editNote;

    if (note != null) {
      setState(() {
        _title = note.title;
        _body = note.body;
      });
    }

    void onSave() async {
      if (_title != '' && _body != '') {
        if (note != null) {
          note.title = _title;
          note.body = _body;
          await editNote(note);
        } else {
          await addNote(Note(title: _title, body: _body));
        }

        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.home, (route) => false);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: onSave,
              icon: Icon(
                Icons.save_rounded,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
              splashRadius: 26,
            ),
          )
        ],
      ),
      backgroundColor: MyColors.background,
      body: Container(
        decoration: BoxDecoration(color: MyColors.tertiary.withOpacity(0.05)),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              initialValue: _title,
              autofocus: true,
              maxLines: null,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: MyColors.primary,
              ),
              decoration: const InputDecoration(
                hintText: 'title',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal, color: MyColors.primary),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                _title = value;
              },
            ),
            TextFormField(
              initialValue: _body,
              style: const TextStyle(
                fontSize: 19,
                height: 1.6,
                color: MyColors.primary,
              ),
              decoration: const InputDecoration(
                hintText: 'note',
                hintStyle: TextStyle(
                  height: 1,
                  fontSize: 20,
                  color: MyColors.primary,
                ),
                border: InputBorder.none,
              ),
              maxLines: null,
              onChanged: (value) {
                _body = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
