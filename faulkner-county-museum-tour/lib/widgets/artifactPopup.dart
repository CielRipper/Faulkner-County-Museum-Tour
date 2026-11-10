import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/objects/artifact.dart';
import 'package:faulkner_county_museum_tour/storage.dart';
import 'package:faulkner_county_museum_tour/widgets/museumWidgets.dart';

/// Popup that shows an artifact's pictures and description.
void showArtifactPopup(BuildContext context, Artifact artifact) {
  // find where this artifact is in its room so we know what comes next
  final roomArtifacts = Storage.data.artifactsOfRoom(artifact.room);
  final i = roomArtifacts.indexOf(artifact);
  final hasNext = i + 1 < roomArtifacts.length;

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(artifact.name),
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
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
          if (hasNext)
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                // use the screen's context here, the popup's is gone once it closes
                showArtifactPopup(context, roomArtifacts[i + 1]);
              },
              child: const Text('Next'),
            ),
        ],
      );
    },
  );
}
