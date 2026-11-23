import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/app_state.dart';
import 'package:faulkner_county_museum_tour/objects/artifact.dart';
import 'package:faulkner_county_museum_tour/storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    Storage.data = Data();
    Storage.appState = _TestApplicationState();
  });
  tearDown(() {
    Storage.appState?.dispose();
    Storage.appState = null;
  });

  test('Dumping test data adds values correctly', () {
    Storage.data.dumpTestData();

    expect(Storage.data.artifacts.length, 6);
    expect(Storage.data.rooms.length, 3);
  });
  test('Creating artifact correctly augments lists', () {
    Storage.data.dumpTestData();
    Storage.data.createArtifact(
      "Pencil",
      "Made with lead and wood",
      "Classroom",
    );
    Storage.data.createArtifact(
      "Tool Display",
      "Various historic tools on the wall",
      "Hallway",
    );

    expect(Storage.data.artifacts.length, 8);
    expect(Storage.data.rooms.length, 4);
  });
  test('Relative getters work in either direction', () {
    Storage.data.dumpTestData();
    Storage.data.createArtifact(
      "Podium",
      "Large speaking podium for a teacher",
      "Classroom",
    );

    expect(Storage.data.artifactsOfRoom("Classroom").length, 4);
    expect(Storage.data.roomOfArtifact("Podium")!.name, "Classroom");
  });
  test('Room destruction removes room and unassigns its artifacts', () {
    Storage.data.dumpTestData();
    Storage.data.destroyRoom("Classroom");

    expect(Storage.data.rooms.containsKey("Classroom"), false);
    expect(Storage.data.roomOfArtifact("Student Desk")!.name, "Unassigned");
  });
  test('Reference assigning augments artifactsByRef', () {
    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    expect(Storage.data.artifactsByRef.length, 2);
  });
  test('Reference assigning adds reference to artifacts', () {
    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    expect(Storage.data.artifacts["Painting"]!.ref, 123);
    expect(Storage.data.artifacts["Model Train"]!.ref, 456);
  });
  test('Get Artifact by reference', () {
    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    expect(
      Storage.data.getArtifactByRef(123),
      Storage.data.artifacts["Painting"],
    );
    expect(
      Storage.data.getArtifactByRef(456),
      Storage.data.artifacts["Model Train"],
    );
  });
  test('Removing Artifact ref makes getter return null', () {
    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    Storage.data.removeReference(artifact: Storage.data.artifacts["Painting"]);
    Storage.data.removeReference(ref: 456);

    expect(Storage.data.getArtifactByRef(123), null);
    expect(Storage.data.getArtifactByRef(456), null);
  });
  test('Removing Artifact ref destroys data in Artifact', () {
    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 456);

    Storage.data.removeReference(artifact: Storage.data.artifacts["Painting"]);
    Storage.data.removeReference(ref: 456);

    expect(Storage.data.artifacts["Painting"]!.ref, null);
    expect(Storage.data.artifacts["Model Train"]!.ref, null);
  });
  test('Overriding reference changes getter output', () {
    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 123);

    expect(
      Storage.data.artifactsByRef[123],
      Storage.data.artifacts["Model Train"],
    );
  });
  test('Overriding reference changes Artifact data', () {
    Storage.data.dumpTestData();
    Storage.data.assignReference(Storage.data.artifacts["Painting"]!, 123);
    Storage.data.assignReference(Storage.data.artifacts["Model Train"]!, 123);

    expect(Storage.data.artifacts["Painting"]!.ref, null);
    expect(Storage.data.artifacts["Model Train"]!.ref, 123);
  });
}

class _TestApplicationState extends ApplicationState {
  @override
  Future<void> init() async {}

  @override
  Future<void> writeArtifact(Artifact artifact) async {}
}
