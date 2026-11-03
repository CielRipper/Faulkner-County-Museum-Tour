import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/objects/room.dart';
import 'package:faulkner_county_museum_tour/theme.dart';

/// todo(Collin): build the artifact list (#5) and popup (#9).
/// Also try to keep the constructor the same.
class ArtifactScreen extends StatelessWidget {
  const ArtifactScreen({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(room.name)),
      body: Center(
        child: Text(
            'Artifacts for rooms coming soon. '
            'Artifacts in sample data.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: MuseumColors.muted),
          ),
      ),
    );
  }
}