import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Note {
  String id = const Uuid().v4();
  String title;
  String body;
  // String date = DateFormat('dd MMM, hh:mma').format(DateTime.now());
  String date = DateTime.now().toString();

  String get dateFormatted =>
      DateFormat('dd MMM, hh:mma').format(DateTime.parse(date));

  Note({required this.title, required this.body});

  factory Note.fromMap(Map<String, dynamic> map) {
    Note note = Note(title: map['title'], body: map['body']);
    note.id = map['id'];
    note.date = map['date'];

    return note;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'body': body, 'date': date};
  }
}
