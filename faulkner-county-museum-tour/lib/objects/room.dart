import 'package:flutter_application_1/objects/artifact.dart';

class Room{

  Room({required this.name}): artifacts = {};

  final String name;
  final Map<String, Artifact> artifacts;
}