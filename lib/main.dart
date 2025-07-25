import 'package:flutter/material.dart';
import 'package:notesportal/screens/home.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubjectFormPage(),
    );
  }
}
