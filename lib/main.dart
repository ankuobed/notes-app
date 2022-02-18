import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:notes/home/home_page.dart';
import 'package:notes/notes/create_note_page.dart';
import 'package:notes/notes/note_details.dart';
import 'package:notes/providers/note_provider.dart';
import 'package:notes/utils/colors.dart';
import 'package:notes/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MaterialApp(
        title: 'Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'Karla',
          appBarTheme: const AppBarTheme(
            elevation: 0,
            foregroundColor: MyColors.primary,
            backgroundColor: MyColors.background,
          ),
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => HomePage(),
          Routes.createNote: (context) => const CreateNote(),
          Routes.noteDetails: (context) => const NoteDetails(),
        },
      ),
    );
  }
}
