import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:notes/home/widgets.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/note.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/responsive.dart';
import 'package:notes/utils/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Note> notes = Provider.of<NotesProvider>(context).notes;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: MyColors.background,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: const Text('Notes',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
        toolbarHeight: 70,
        actions: [
          Responsive.isDesktop(context)
              ? Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: MyColors.secondary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.all(13),
                  child: IconButton(
                      splashRadius: 25,
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.createNote),
                      icon: const Icon(
                        Icons.add,
                        size: 25,
                      )),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: IconButton(
                splashRadius: 25,
                onPressed: () {},
                icon: const Icon(
                  Icons.sort,
                  size: 25,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                splashRadius: 25,
                onPressed: () {
                  showSearch(
                      context: context, delegate: NotesSearchDelegate(notes));
                },
                icon: const Icon(
                  Icons.search,
                  size: 25,
                )),
          ),
        ],
      ),
      backgroundColor: MyColors.background,
      body: Notes(notes: notes),
      floatingActionButton: !Responsive.isDesktop(context)
          ? FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, Routes.createNote),
            )
          : Container(),
    );
  }
}

class NotesSearchDelegate extends SearchDelegate {
  final List<Note> notes;

  NotesSearchDelegate(this.notes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Widget> results = notes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .map((note) => ListTile(
              title: Text(note.title,
                  style: const TextStyle(color: MyColors.primary)),
              leading: Icon(
                Icons.note_alt_outlined,
                color: MyColors.primary.withOpacity(0.7),
              ),
              onTap: () => Navigator.pushNamed(context, '/note-details',
                  arguments: note),
            ))
        .toList();

    return results.isNotEmpty
        ? Container(
            decoration: const BoxDecoration(color: MyColors.background),
            child: Material(
                color: MyColors.tertiary.withOpacity(0.05),
                child: ListView(children: results)),
          )
        : Container(
            decoration: const BoxDecoration(color: MyColors.background),
            child: Container(
              decoration:
                  BoxDecoration(color: MyColors.tertiary.withOpacity(0.04)),
              child: const Center(
                child: Text('No notes found!',
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.primary,
                    )),
              ),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Widget> suggestions = notes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .map((note) => ListTile(
              title: Text(note.title,
                  style: const TextStyle(color: MyColors.primary)),
              leading: Icon(
                Icons.note_alt_outlined,
                color: MyColors.primary.withOpacity(0.7),
              ),
              onTap: () => Navigator.pushNamed(context, '/note-details',
                  arguments: note),
            ))
        .toList();

    return suggestions.isNotEmpty
        ? Container(
            decoration: const BoxDecoration(color: MyColors.background),
            child: Material(
                color: MyColors.tertiary.withOpacity(0.05),
                child: ListView(children: suggestions)),
          )
        : Container(
            decoration: const BoxDecoration(color: MyColors.background),
            child: Container(
              decoration:
                  BoxDecoration(color: MyColors.tertiary.withOpacity(0.04)),
              child: const Center(
                child: Text('No notes found!',
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.primary,
                    )),
              ),
            ),
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 1,
        backgroundColor: MyColors.background,
        foregroundColor: MyColors.primary,
      ),
      primarySwatch: Colors.deepOrange,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 19, fontFamily: 'Karla'),
      ),
    );
  }

  @override
  TextStyle? get searchFieldStyle =>
      const TextStyle(fontSize: 19, fontFamily: 'Karla');
}
