import 'package:faulkner_county_museum_tour/objects/room.dart';
import 'package:faulkner_county_museum_tour/storage.dart';

class Artifact{
  Artifact({required this.name, required this.description, required this.room}): ref = null;

  final String name;
  final String description;
  String room;
  int? ref;

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