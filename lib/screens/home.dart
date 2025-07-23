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
        backgroundColor: Color(0xFFF5F4F4),
        appBar: AppBar(
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 20),
              onPressed: () {},
              icon: Icon(CupertinoIcons.profile_circled, size: 24, color: Colors.black),
            )
          ],
          title: Text(
            'NotesPortal',
            style: GoogleFonts.inter(
              letterSpacing: -1,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          backgroundColor: Color(0xFFF5F4F4),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.only(
                left: 34.0,
                right: 34.0,
                top: 30.0,
                bottom: 28,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _subjectController,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Subject',
                            labelStyle: GoogleFonts.inter(
                              color: Colors.black54,
                              fontSize: 17,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none, // Removes the border
                            ),
                            filled: true,
                            fillColor: Color(0xFFE7E7E7), // Subtle grey background
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 10), // Indents the icon
                              child: Icon(
                                CupertinoIcons.book,
                                color: Colors.black54,
                                size: 20, // Slightly smaller icon for iOS feel
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 50,
                              minHeight: 40,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never, // Makes it more iOS-like
                            hintStyle: GoogleFonts.inter(
                              color: Colors.black54,
                              fontSize: 17,
                            ),
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ResultsScreen(
                                    notes: SupaBaseAPI().traverseFileLinks(
                                      _subjectController.text.toString()
                                    )
                                  )
                                )
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            iconAlignment: IconAlignment.end,
                            backgroundColor: Color(0xFF53399A),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}