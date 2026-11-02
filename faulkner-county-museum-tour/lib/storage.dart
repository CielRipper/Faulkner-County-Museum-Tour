import 'package:flutter_application_1/objects/artifact.dart';
import 'package:flutter_application_1/objects/room.dart';

class Storage{
  static Data data = Data();
}

class Data{
  Data() : artifacts={}, rooms={};

  Map<String, Artifact> artifacts;
  Map<String, Room> rooms;


}