import 'package:flutter_application_1/objects/artifact.dart';

class Room{

  Room({required this.name}): artifacts = [];

  final String name;
  final List<String> artifacts;

  bool addArtifact(String artifactName){
    if(artifacts.contains(artifactName)){
        return false;
    }
    else{
        artifacts.add(artifactName);
        return true;
    }   
  }
}