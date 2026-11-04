import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/objects/room.dart';
import 'package:faulkner_county_museum_tour/storage.dart';
import 'package:faulkner_county_museum_tour/theme.dart';
import 'package:faulkner_county_museum_tour/widgets/artifactPopup.dart';
import 'package:faulkner_county_museum_tour/widgets/museumWidgets.dart';

/// List of artifacts in the room that was tapped.
class ArtifactScreen extends StatelessWidget {
  const ArtifactScreen({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    /// Room only stores artifact names, so get the full artifacts from Storage.
    final artifacts = Storage.data.artifactsOfRoom(room.name);

    Widget body;
    if (artifacts.isEmpty) {
      body = const Center(child: Text('No artifacts in this room yet.'));
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: artifacts.length,
        itemBuilder: (context, index) {
          final artifact = artifacts[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const MuseumImage(width: 40, height: 40, iconSize: 24),
              title: Text(artifact.name),
              trailing: const Icon(Icons.chevron_right, color: MuseumColors.green),
              onTap: () {
                showArtifactPopup(context, artifact);
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(room.name)),
      body: body,
    );
  }
}