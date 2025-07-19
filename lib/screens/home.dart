import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectFormPage extends StatefulWidget {
  @override
  _SubjectFormPageState createState() => _SubjectFormPageState();
}

class _SubjectFormPageState extends State<SubjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _subject;
  String? _selectedYear;
  String? _selectedSemester;

  final List<String> _years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final List<String> _semesters = ['Semester 1', 'Semester 2'];

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: textTheme),
      child: Scaffold(
        appBar: AppBar(
          title: Text('NotesPortal Login', style: GoogleFonts.inter()),
          backgroundColor: Colors.greenAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      style: GoogleFonts.inter(),
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        labelStyle: GoogleFonts.inter(),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.book),
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter a subject' : null,
                      onSaved: (value) => _subject = value,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Year',
                        labelStyle: GoogleFonts.inter(),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      style: GoogleFonts.inter(color: Colors.black),
                      items: _years
                          .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year, style: GoogleFonts.inter()),
                      ))
                          .toList(),
                      onChanged: (value) => setState(() => _selectedYear = value),
                      validator: (value) =>
                      value == null ? 'Please select a year' : null,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Semester',
                        labelStyle: GoogleFonts.inter(),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school),
                      ),
                      style: GoogleFonts.inter(color: Colors.black),
                      items: _semesters
                          .map((sem) => DropdownMenuItem(
                        value: sem,
                        child: Text(sem, style: GoogleFonts.inter()),
                      ))
                          .toList(),
                      onChanged: (value) => setState(() => _selectedSemester = value),
                      validator: (value) =>
                      value == null ? 'Please select a semester' : null,
                    ),
                    SizedBox(height: 24),


                    // subject

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Subject: $_subject\nYear: $_selectedYear\nSemester: $_selectedSemester',
                                style: GoogleFonts.inter(),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
