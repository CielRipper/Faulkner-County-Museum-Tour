import 'package:flutter/material.dart';
import 'package:flutter_application_1/storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Dumping test data adds values correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    Storage.data.dumpTestData();

    expect(Storage.data.artifacts.length, 6);
    expect(Storage.data.rooms.length, 3);
  });
  testWidgets('Creating artifact correctly augments lists', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    Storage.data.dumpTestData();
    Storage.data.createArtifact("Pencil", "Made with lead and wood", "Classroom");
    Storage.data.createArtifact("Tool Display", "Various historic tools on the wall", "Hallway");

    expect(Storage.data.artifacts.length, 8);
    expect(Storage.data.rooms.length, 4);
  });
  testWidgets('Relative getters work in either direction', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    Storage.data.dumpTestData();
    Storage.data.createArtifact("Podium", "Large speaking podium for a teacher", "Classroom");

    expect(Storage.data.artifactsOfRoom("Classroom").length, 4);
    expect(Storage.data.roomOfArtifact("Podium")!.name, "Classroom");
  });
  testWidgets('Room destruction removes room and unassigns its artifacts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    Storage.data.dumpTestData();
    Storage.data.destroyRoom("Classroom");

    expect(Storage.data.rooms.containsKey("Classroom"), false);
    expect(Storage.data.roomOfArtifact("Student Desk")!.name, "Unassigned");
  });
}
