import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notesportal/model/model.dart';

class SupaBaseAPI {
  Future<List<Note>> traverseFileLinks(String subject) async {
    List<Note> notes = [];

    String url = 'http://127.0.0.1:8000/fileretreive';
    Map data = {
      'subjectname': subject
    };
    print(subject);
    var body = jsonEncode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (int x = 0; x < res["sending"].length; x++) {
        Note current = Note(
          author: res["sending"][x]["uploaded_by"],
          pdfLink: res["sending"][x]["filelink"]
        );
        notes.add(current);
      }
    }

    return notes;
  }
}