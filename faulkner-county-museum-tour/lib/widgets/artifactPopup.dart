import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/objects/artifact.dart';
import 'package:faulkner_county_museum_tour/pages/artifactScreen.dart';
import 'package:faulkner_county_museum_tour/storage.dart';
import 'package:faulkner_county_museum_tour/theme.dart';
import 'package:faulkner_county_museum_tour/widgets/museumWidgets.dart';

/// Popup that shows an artifact's pictures and description.
void showArtifactPopup(BuildContext context, Artifact artifact) {
  // find where this artifact is in its room so we know what comes next
  final roomArtifacts = Storage.data.artifactsOfRoom(artifact.room);
  final i = roomArtifacts.indexOf(artifact);
  final hasNext = i + 1 < roomArtifacts.length;

  // on the last artifact, find the next room that has artifacts
  String nextRoom = '';
  if (!hasNext) {
    final roomNames = Storage.data.rooms.keys.toList();
    for (int r = roomNames.indexOf(artifact.room) + 1; r < roomNames.length; r++) {
      final name = roomNames[r];
      if (name != 'Unassigned' && Storage.data.artifactsOfRoom(name).isNotEmpty) {
        nextRoom = name;
        break;
      }
    }
  }

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        // artifact name on the left, X to close on the right
        title: Row(
          children: [
            Expanded(child: Text(artifact.name)),
            IconButton(
              icon: const Icon(Icons.close, size: 32, color: Colors.red),
              onPressed: () => Navigator.pop(dialogContext),
            ),
          ],
        ),
        // scrolls if the description is long
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // placeholder until we have real photos
              const Center(child: MuseumImage(width: 200, height: 150)),
              const SizedBox(height: 16),
              Text(artifact.description),
            ],
          ),
        ),
        actions: [
          if (hasNext || nextRoom.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.arrow_forward, size: 32, color: MuseumColors.green),
              onPressed: () {
                Navigator.pop(dialogContext);
                // use the screen's context here, the popup's is gone once it closes
                if (hasNext) {
                  showArtifactPopup(context, roomArtifacts[i + 1]);
                } else {
                  showRoomChangePopup(context, nextRoom);
                }
              },
            ),
        ],
      );
    },
  );
}

/// Lets the visitor know they're moving into a new room.
void showRoomChangePopup(BuildContext context, String roomName) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text('Entering $roomName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, size: 32, color: MuseumColors.green),
            onPressed: () {
              Navigator.pop(dialogContext);

              // grab the navigator first, the old room screen is gone after the swap
              final navigator = Navigator.of(context);

              // swap the room list behind the popup to the new room
              final room = Storage.data.rooms[roomName]!;
              navigator.pushReplacement(
                MaterialPageRoute(builder: (_) => ArtifactScreen(room: room)),
              );

              final firstArtifact = Storage.data.artifactsOfRoom(roomName).first;
              showArtifactPopup(navigator.context, firstArtifact);
            },
          ),
        ],
      );
    },
  );
}
