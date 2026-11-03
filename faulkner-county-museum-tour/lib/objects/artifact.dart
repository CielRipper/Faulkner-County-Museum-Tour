import 'package:flutter_application_1/objects/room.dart';
import 'package:flutter_application_1/storage.dart';

class Artifact{
  Artifact({required this.name, required this.description, required this.room});

  final String name;
  final String description;
  String room;

  void moveTo(String newRoomID){
    removeFrom(room);
    addTo(newRoomID);
    room = newRoomID;
  }

  removeFrom(String oldRoomID){
    Storage.data.rooms[oldRoomID]?.artifacts.remove(name);
    addTo("Unassigned");
  }

  void addTo(String newRoomID){
    Room? newRoom = Storage.data.rooms[newRoomID];
    newRoom ??= Storage.data.createRoom(newRoomID);
    newRoom!.artifacts.add(name);
    room = newRoomID;
  }

}