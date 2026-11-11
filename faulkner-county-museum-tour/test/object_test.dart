import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:faulkner_county_museum_tour/main.dart';

void main() {
  testWidgets('Dumping test data adds values correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();

    expect(Storage.data.artifacts.length, 6);
    expect(Storage.data.rooms.length, 3);
  });
  testWidgets('Creating artifact correctly augments lists', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.createArtifact("Pencil", "Made with lead and wood", "Classroom");
    Storage.data.createArtifact("Tool Display", "Various historic tools on the wall", "Hallway");

    expect(Storage.data.artifacts.length, 8);
    expect(Storage.data.rooms.length, 4);
  });
  testWidgets('Relative getters work in either direction', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.createArtifact("Podium", "Large speaking podium for a teacher", "Classroom");

    expect(Storage.data.artifactsOfRoom("Classroom").length, 4);
    expect(Storage.data.roomOfArtifact("Podium")!.name, "Classroom");
  });
  testWidgets('Room destruction removes room and unassigns its artifacts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.destroyRoom("Classroom");

    expect(Storage.data.rooms.containsKey("Classroom"), false);
    expect(Storage.data.roomOfArtifact("Student Desk")!.name, "Unassigned");
  });
  testWidgets('Reference assigning augments artifactsByRef', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    expect(Storage.data.artifactsByRef.length, 2);
  });
  testWidgets('Reference assigning adds reference to artifacts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    expect(Storage.data.artifacts["Painting"]!.ref, 123);
    expect(Storage.data.artifacts["Model Train"]!.ref, 456);
  });
  testWidgets('Get Artifact by reference', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    expect(Storage.data.getArtifactByRef(123), Storage.data.artifacts["Painting"]);
    expect(Storage.data.getArtifactByRef(456), Storage.data.artifacts["Model Train"]);
  });
  testWidgets('Removing Artifact ref makes getter return null', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    Storage.data.removeReference(artifact: Storage.data.artifacts["Painting"]);
    Storage.data.removeReference(ref: 456);

    expect(Storage.data.getArtifactByRef(123), null);
    expect(Storage.data.getArtifactByRef(456), null);
  });
  testWidgets('Removing Artifact ref destroys data in Artifact', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    Storage.data.removeReference(artifact: Storage.data.artifacts["Painting"]);
    Storage.data.removeReference(ref: 456);

    expect(Storage.data.artifacts["Painting"]!.ref, null);
    expect(Storage.data.artifacts["Model Train"]!.ref, null);
  });
  testWidgets('Overriding reference changes getter output', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 123);

    expect(Storage.data.artifactsByRef[123], Storage.data.artifacts["Model Train"]);
  });
  testWidgets('Overriding reference changes Artifact data', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MuseumTourApp());

    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 123);

    expect(Storage.data.artifacts["Painting"]!.ref, null);
    expect(Storage.data.artifacts["Model Train"]!.ref, 123);
  });
}
