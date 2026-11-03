import 'package:flutter_application_1/objects/artifact.dart';
import 'package:flutter_application_1/objects/room.dart';

class Storage{
  static Data data = Data();
}

class Data{
  Data() : artifacts={}, rooms={};

  Map<String, Artifact> artifacts;
  Map<String, Room> rooms;

  bool createRoom(String name){
    if(rooms.containsKey(name)){
      return false;
    }
    rooms[name] = Room(name: name);
    return true;
  }

  bool createArtifact(String name, String description, String? room){
    if(artifacts.containsKey(name)){
      return false;
    }
    artifacts[name] = Artifact(name: name, description: description, room: room??"Unassigned");
    if(room != null){
      if(!rooms.containsKey(room)){
        createRoom(room);
      }
    }
    rooms[room]!.addArtifact(name);
    return true;
  }

  List<Artifact> artifactsOfRoom(String roomName){
    if(rooms.containsKey(roomName)){
      return [for (String n in rooms[roomName]!.artifacts) artifacts[n]!];
    }
    return [];
  }

  Room? roomOfArtifact(String artifactName){
    if(artifacts.containsKey(artifactName)){
      return rooms[artifacts[artifactName]!.room]!;
    }
    else{
      return null;
    }
  }

  void dumpTestData(){
    rooms = {};
    artifacts = {};
    createArtifact("Painting", "Painted with oil and acrylic", "Foyer");
    createArtifact("Painting 2", "Painted with tempera", "Foyer");
    createArtifact("Model Train", "Diorama of figures and landscape", "Train Room");
    createArtifact("Student Desk", "Used for classwork", "Classroom");
    createArtifact("Student Chair", "Mass-produced historic chair", "Classroom");
    createArtifact("Chalkboard", "Home to many cool S depictions", "Classroom");
  }
}