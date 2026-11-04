import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/objects/artifact.dart';
import 'package:faulkner_county_museum_tour/widgets/museumWidgets.dart';

/// Popup that shows an artifact's pictures and description.
void showArtifactPopup(BuildContext context, Artifact artifact) {
  showDialog(
    context: context,
    builder: (context) {
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
