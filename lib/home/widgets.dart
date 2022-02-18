import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/routes.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key, required this.notes}) : super(key: key);

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Image(
                  image: AssetImage('assets/images/empty-list.png'),
                  width: 220,
                ),
                const Text(
                  "You don't have any notes",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Color.fromARGB(255, 146, 146, 146)),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Add a note",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Color.fromARGB(255, 146, 146, 146)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.createNote),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
                  child:
                      const Text('Add note', style: TextStyle(fontSize: 16.5)),
                ),
                const SizedBox(height: 100),
              ],
            ),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 150,
                // childAspectRatio: 1,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25),
            itemCount: notes.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            itemBuilder: (context, index) {
              Note note = notes[index];

              return NoteItem(note: note);
            }, // horizontal, this produces 2 rows.
          );
  }
}

class NoteItem extends StatelessWidget {
  final Note note;
  const NoteItem({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () =>
          Navigator.pushNamed(context, Routes.noteDetails, arguments: note),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.primary.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.01),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(2, 2), // changes position of shadow
              ),
            ]),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  color: MyColors.primary,
                ),
              ),
            ),
            Text(note.body,
                maxLines: 3,
                style: TextStyle(
                    height: 1.5,
                    fontSize: 15.5,
                    color: Colors.black.withOpacity(0.65),
                    overflow: TextOverflow.ellipsis)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                note.dateFormatted.toUpperCase(),
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
