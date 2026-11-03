import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/objects/room.dart';
import 'package:faulkner_county_museum_tour/objects/sampleData.dart';
import 'package:faulkner_county_museum_tour/theme.dart';
import 'package:faulkner_county_museum_tour/widgets/museumWidgets.dart';
import 'package:faulkner_county_museum_tour/pages/artifactScreen.dart';

/// Home screen: a list of rooms.
/// Tapping a room opens its artifacts.
class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key, this.rooms = sampleRooms});

  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faulkner County Museum')
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          Text('Rooms', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          for (final room in rooms) ...[
            _RoomCard(
              room: room,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ArtifactScreen(room: room)),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}


/// A room shown like a Facebook post card: photo on top, name below.
class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room, required this.onTap});

  final Room room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MuseumImage(path: room.imagePath, height: 140, iconSize: 48),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(room.name, style: text.titleMedium),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: MuseumColors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}