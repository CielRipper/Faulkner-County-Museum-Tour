import 'package:flutter/material.dart';
import 'pages/roomScreen.dart';
import 'storage.dart';
import 'theme.dart';

void main() {
  /// Fake rooms and artifacts from Jack's backend until Firebase is set up.
  Storage.data.dumpTestData();
  runApp(const MuseumTourApp());
}

class MuseumTourApp extends StatelessWidget {
  const MuseumTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faulkner County Museum Tour',
      theme: buildMuseumTheme(),
      home: const RoomScreen(),
    );
  }
}