import 'package:flutter_application_1/objects/room.dart';
import 'package:flutter_application_1/storage.dart';

class Artifact{
  Artifact({required this.name, required this.description, required this.room});

  final String name;
  final String description;
  final String room;

  bool moveTo(String newRoomID){
    bool removed = removeFrom(room);
    bool added = addTo(newRoomID);
    return removed && added;
  }

  bool removeFrom(String oldRoomID){
    Room? oldRoom = Storage.data.rooms[oldRoomID];
    if(oldRoom?.artifacts.remove(name) == null){
        return false;
    }
    else{
        return true;
    }
  }

  bool addTo(String newRoomID){
    Room? newRoom = Storage.data.rooms[newRoomID];
    if(newRoom == null){
        return false;
    }
    else{
        newRoom.artifacts[name] = this;
        return true;
    }
  }

}