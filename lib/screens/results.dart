import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesportal/model/model.dart';

class ResultsScreen extends StatelessWidget {
  final Future<List<Note>> notes;

  const ResultsScreen({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);
    print(notes);
    return Theme(
      data: Theme.of(context).copyWith(textTheme: textTheme),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          title: Text(
            'Results',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          backgroundColor: Color(0xFF222222),
        ),
        backgroundColor: Color(0xFF1A1A1A),
        body: Container(
          child: FutureBuilder(future: notes,
              builder: (context, snapshot) {
                final noteList = snapshot.data!;
                print(noteList[0]); // ✅ Safe to access

                return ListView.builder(
                  itemCount: noteList.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(noteList[index].author, style: TextStyle(color: Colors.white),));
                    // Future<PDFDocument> doc = PDFDocument.fromURL(noteList[index].pdfLink);
                    // return PDFDocument(document: doc);
                  },
                );
            }),
        )
      ),
    );
  }
}
