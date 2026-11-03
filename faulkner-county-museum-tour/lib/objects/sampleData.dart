import 'artifact.dart';
import 'room.dart';

/// Fake rooms and artifacts so the screens have something to show
/// until real data comes from Firebase.
const List<Room> sampleRooms = [
  Room(
    id: 'main-hall',
    name: 'Main Hall',
    artifacts: [
      Artifact(
        id: 'a1',
        name: 'Lorem ipsum dolor sit amet',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        exhibitNumber: 101,
        isImportant: true,
      ),
      Artifact(
        id: 'a2',
        name: 'Lorem ipsum dolor sit amet',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        exhibitNumber: 102,
      ),
    ],
  ),
  Room(
    id: 'farm-life',
    name: 'Farm Life',
    artifacts: [
      Artifact(
        id: 'a3',
        name: 'Lorem ipsum dolor sit amet',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        exhibitNumber: 201,
      ),
      Artifact(
        id: 'a4',
        name: 'Lorem ipsum dolor sit amet',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        exhibitNumber: 202,
      ),
      Artifact(
        id: 'a5',
        name: 'Lorem ipsum dolor sit amet',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        exhibitNumber: 203,
        isImportant: true,
      ),
    ],
  ),
  Room(
    id: 'cabin',
    name: 'Outdoor Cabin',
    artifacts: [
      Artifact(
        id: 'a6',
        name: 'Lorem ipsum dolor sit amet',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        exhibitNumber: 301,
      ),
    ],
  ),
];