import 'package:flutter/material.dart';
import 'pages/introScreen.dart';
import 'storage.dart';
import 'theme.dart';

void main() {
  loadTestData();
  runApp(const MuseumTourApp());
}

/// Fake rooms, artifacts, and exhibit numbers until Firebase is set up.
/// Also used by the widget tests so they start with the same data.
void loadTestData() {
  Storage.data.dumpTestData();

  // dumpTestData doesn't clear old exhibit numbers, so start fresh.
  Storage.data.artifactsByRef = {};

  // Test exhibit numbers for the keypad (room number + item number).
  const testNumbers = {
    'Painting': 101,
    'Painting 2': 102,
    'Model Train': 201,
    'Student Desk': 301,
    'Student Chair': 302,
    'Chalkboard': 303,
  };
  testNumbers.forEach((name, number) {
    final artifact = Storage.data.artifacts[name];
    if (artifact != null) {
      Storage.data.assignReference(artifact, number);
    }
  });
}

class MuseumTourApp extends StatelessWidget {
  const MuseumTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faulkner County Museum Tour',
      theme: buildMuseumTheme(),
      home: const IntroScreen(),
    );
  }
}