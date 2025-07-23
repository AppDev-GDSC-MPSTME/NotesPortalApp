import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesportal/model/model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResultsScreen extends StatelessWidget {
  final Future<List<Note>> notes;

  const ResultsScreen({Key? key, required this.notes}) : super(key: key);

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: textTheme),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          title: Text(
            'Results',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          backgroundColor: Color(0xFFEEEEEE),
        ),
        backgroundColor: Color(0xFFF5F4F4),
        body: Container(
          child: FutureBuilder<List<Note>>(
            future: notes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB4A6D5)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading notes...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Error loading notes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsScreen(notes: notes),
                            ),
                          );
                        },
                        child: Text(
                          'Try Again',
                          style: TextStyle(
                            color: Color(0xFFB4A6D5),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.note_outlined,
                        color: Colors.grey,
                        size: 60,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No notes found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final noteList = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.only(top: 30),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: Text(noteList[index].fileName),
                                backgroundColor: Color(0xFFF5F4F4),
                                iconTheme: IconThemeData(color: Colors.black),
                              ),
                              body: SfPdfViewer.network(
                                noteList[index].pdfLink,
                                canShowPaginationDialog: false,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 18, right: 18, bottom: 22),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFEEEEEE),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${index + 1}. ${noteList[index].fileName}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("@", style: TextStyle(color: Colors.grey, fontSize: 15),),
                                    Text(
                                      noteList[index].author,
                                      style: TextStyle(color: Color(0xFFB4A6D5), fontSize: 15, fontWeight: FontWeight.w500)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SfPdfViewer.network(
                                  noteList[index].pdfLink,
                                  canShowPaginationDialog: false,
                                  canShowScrollHead: false,
                                  enableDoubleTapZooming: false,
                                  enableTextSelection: false,
                                  pageSpacing: 0,
                                  initialZoomLevel: 1.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    capitalizeFirstLetter(noteList[index].desc),
                                    style: TextStyle(color: Colors.black45, fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_right_circle_fill,
                                  color: Color(0xFFB4A6D5),
                                  size: 18
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}