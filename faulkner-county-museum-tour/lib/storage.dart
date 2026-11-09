import 'package:faulkner_county_museum_tour/objects/artifact.dart';
import 'package:faulkner_county_museum_tour/objects/room.dart';

class Storage{
  static Data data = Data();
}

class Data{
  Data() : artifacts={}, rooms={}, artifactsByRef={};

  Map<String, Artifact> artifacts;
  Map<int, Artifact> artifactsByRef;
  Map<String, Room> rooms;

  Room? createRoom(String name){
    if(rooms.containsKey(name)){
      return null;
    }
    rooms[name] = Room(name: name);
    return rooms[name];
  }

  Artifact? createArtifact(String name, String description, String? room){
    if(artifacts.containsKey(name)){
      return null;
    }
    artifacts[name] = Artifact(name: name, description: description, room: room??"Unassigned");
    if(room != null){
      if(!rooms.containsKey(room)){
        createRoom(room);
      }
    } else if(!rooms.containsKey("Unassigned")){
      createRoom("Unassigned");
    }
    rooms[room ?? "Unassigned"]!.addArtifact(name);
    return artifacts[name];
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
  
  bool destroyRoom(String roomName){
    if(rooms.containsKey(roomName)){
      List<Artifact> artifactsToMove = [];
      for (String artifactName in rooms[roomName]!.artifacts){
        artifactsToMove.add(artifacts[artifactName]!);
      }
      for(Artifact movingArtifact in artifactsToMove){
        movingArtifact.moveTo("Unassigned");
      }
      rooms.remove(roomName);
      return true;
    }
    else{
      return false;
    }
  }

  Artifact? getArtifactByRef(int ref){
    if(artifactsByRef.containsKey(ref)){
      return artifactsByRef[ref];
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