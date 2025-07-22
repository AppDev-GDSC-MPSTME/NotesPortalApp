import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesportal/model/model.dart';
import 'package:notesportal/network/network.dart';
import 'package:notesportal/screens/results.dart';

class SubjectFormPage extends StatefulWidget {
  @override
  _SubjectFormPageState createState() => _SubjectFormPageState();
}

class _SubjectFormPageState extends State<SubjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _subjectController = TextEditingController();
  String? _subject;
  String? _selectedYear;
  String? _selectedSemester;

  final List<String> _years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> _semesters = ['Semester 1', 'Semester 2'];

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: textTheme),
      child: Scaffold(
        backgroundColor: Color(0xFF222222),
        appBar: AppBar(
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 20),
              onPressed: () {},
              icon: Icon(CupertinoIcons.profile_circled, size: 24, color: Colors.white),
            )
          ],
          title: Text(
            'NotesPortal',
            style: GoogleFonts.inter(
              letterSpacing: -1,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          backgroundColor: Color(0xFF222222),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _subjectController,
                        style: GoogleFonts.inter(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          labelStyle: GoogleFonts.inter(color: Colors.white),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(CupertinoIcons.book, color: Colors.white),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter a subject' : null,
                        onSaved: (value) => _subject = value,
                      ),
                      SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            _subject = _subjectController.text;

                            // Future<List<Note>> results = SupaBaseAPI().traverseFileLinks(_subjectController.text.toString());
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultsScreen(notes: SupaBaseAPI().traverseFileLinks(_subjectController.text.toString()))));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          iconAlignment: IconAlignment.end,
                          backgroundColor: Color(0xFF573DA0),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Submit',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.4,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right_circle_fill,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
