/// A single item on display in the museum.
/// Placeholder model until Jack's backend data structures are ready.
class Artifact {
  const Artifact({
    required this.id,
    required this.name,
    required this.description,
    this.exhibitNumber,
    this.imagePaths = const [],
    this.isImportant = false,
  });

  final String id;
  final String name;
  final String description;

  /// Number visitors can type on the keypad screen.
  final int? exhibitNumber;

  /// No asset paths for now.
  /// An empty list shows placeholder boxes.
  final List<String> imagePaths;

  /// Important artifacts get a "Featured" badge.
  final bool isImportant;
}