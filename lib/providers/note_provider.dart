import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Sort { dateAscending, dateDescending, titleAscending, titleDescending }

class NotesProvider extends ChangeNotifier {
  List<Note> _notes = [];

  NotesProvider() {
    getNotes().then((notes) {
      _notes = notes;
      notifyListeners();
    });
  }

  List<Note> get notes => _notes;

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();

    List notes = jsonDecode(prefs.getString('notes') ?? '[]');
    notes = notes.map((noteMap) => Note.fromMap(noteMap)).toList();

    return notes as List<Note>;
  }

  void addNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();

    _notes = [note, ..._notes];

    prefs.setString(
        'notes', jsonEncode(_notes.map((note) => note.toMap()).toList()));

    notifyListeners();
  }

  void editNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();

    Note oldNote = _notes.firstWhere((n) => n.id == note.id);

    _notes[notes.indexOf(oldNote)] = note;

    prefs.setString(
        'notes', jsonEncode(_notes.map((note) => note.toMap()).toList()));

    notifyListeners();
  }

  void deleteNote(String id) async {
    final prefs = await SharedPreferences.getInstance();

    Note note = _notes.firstWhere((n) => n.id == id);

    _notes.removeAt(_notes.indexOf(note));

    prefs.setString(
        'notes', jsonEncode(_notes.map((note) => note.toMap()).toList()));

    notifyListeners();
  }

  void sortNotes(Sort s) async {
    switch (s) {
      case Sort.titleAscending:
        _notes.sort((a, b) => b.title.compareTo(a.title));
        break;
      case Sort.titleDescending:
        _notes.sort((a, b) => a.title.compareTo(b.title));
        break;
      case Sort.dateAscending:
        _notes.sort(
            (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
        break;
      case Sort.dateDescending:
        _notes.sort(
            (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
        break;
    }

    notifyListeners();
  }
}
