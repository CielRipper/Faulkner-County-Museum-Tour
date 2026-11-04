import 'package:faulkner_county_museum_tour/objects/artifact.dart';

class Room{

  Room({required this.name}): artifacts = [];

  final String name;
  final List<String> artifacts; // order matters here, as it will define the path 

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