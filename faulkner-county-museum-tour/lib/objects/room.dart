import 'artifact.dart';

/// A room in the museum (or a virtual room) holding artifacts.
/// Placeholder model until Jack's backend data structures are ready.
class Room {
  const Room({
    required this.id,
    required this.name,
    this.description = '',
    this.imagePath,
    this.artifacts = const [],
    this.isVirtual = false,
  });

  final String id;
  final String name;
  final String description;
  
  /// No asset paths for now.
  /// null shows a placeholder.
  final String? imagePath;
  final List<Artifact> artifacts;

  /// Virtual rooms aren't physically in the museum but can still be viewed.
  final bool isVirtual;
}