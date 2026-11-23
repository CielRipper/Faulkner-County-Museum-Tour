import 'dart:async';

import 'package:faulkner_county_museum_tour/objects/artifact.dart';
import 'package:faulkner_county_museum_tour/objects/room.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faulkner_county_museum_tour/objects/account.dart';

import 'storage.dart';


class ApplicationState extends ChangeNotifier{
  ApplicationState(){
    future = completedLoad.future;
    unawaited(init());
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _profilesSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _artifactSubscription;

  bool _disposed = false;
  Completer<void> completedLoad = Completer();
  late Future<void> future;
  void Function()? callback;

  Future<void> init() async {
    try {

      //FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
      _authSubscription = FirebaseAuth.instance.userChanges().listen(
        (user) {
          _loggedIn = user != null;
          Storage.data.loggedIn = loggedIn;
          if(_loggedIn) {
            Storage.data.currentUserID = user!.uid;
          } else {
            Storage.data.currentUserID = null;
          }
          notifyListeners();
        },
        onError: (Object error, StackTrace stackTrace) {
          _reportError('Authentication', error, stackTrace);
        },
      );

      _profilesSubscription = FirebaseFirestore.instance
        .collection('accounts')
        .snapshots()
        .listen(
          (snapshot) {
            try {
              final tempData = <String, Account>{};
              for (final document in snapshot.docs) {
                final data = document.data();
                tempData[document.id] = Account(
                  admin: false,
                );
              }
              Storage.data.accounts = tempData;
              notifyListeners();
            } catch(error, stackTrace){
              _reportError('Accounts data failure', error, stackTrace);
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            _reportError('Accounts', error, stackTrace);
          },
        );

        _artifactSubscription = FirebaseFirestore.instance
          .collection('rooms')
          .snapshots()
          .listen(
            (snapshot) {
              try {
                final tempArtifacts = <String, Artifact>{};
                final tempArtifactsByRef = <int, Artifact>{};
                final tempRooms = <String, Room>{};
                for(final document in snapshot.docs){
                  final data = document.data();
                  final tempRoom = Room(name: document.id);
                  for(final Map<String, dynamic> artifact in data['artifacts']){
                    final tempArtifact = Artifact(
                      description: artifact['description'],
                      name: artifact['name'],
                      room: document.id,
                    );
                    tempArtifacts[tempArtifact.name] = tempArtifact;
                    tempArtifactsByRef[artifact['reference']] = tempArtifact;
                    tempRoom.artifacts.add(tempArtifact.name);
                  }
                  tempRooms[document.id] = tempRoom;
                }
                Storage.data.artifacts = tempArtifacts;
                Storage.data.artifactsByRef = tempArtifactsByRef;
                Storage.data.rooms = tempRooms;

                notifyListeners();

                if(callback != null) callback!();
              } catch (error, stackTrace) {
                _reportError('Storage writing failed', error, stackTrace);
              }
            },
            onError: (Object error, StackTrace stackTrace){
              _reportError('Storage writing failed', error, stackTrace);
            }
          );
    } catch (error, stackTrace) {
      _reportError('Firebase initialization', error, stackTrace);
    }

  }

  Future<void> writeArtifact(Artifact artifact) async {
    final roomDoc = FirebaseFirestore.instance.collection('rooms').doc(artifact.room);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(roomDoc);
      final existing = snapshot.data()?['artifacts'];
      final artifacts = existing is Iterable
          ? List<Map<String, dynamic>>.from(
              existing.map((item) => Map<String, dynamic>.from(item as Map)),
            )
          : <Map<String, dynamic>>[];

      final updatedArtifact = <String, dynamic>{
        'description': artifact.description,
        'name': artifact.name,
        'reference': artifact.ref ?? -1,
      };

      final existingIndex = artifacts.indexWhere(
        (item) => item['name'] == artifact.name,
      );
      if (existingIndex == -1) {
        artifacts.add(updatedArtifact);
      } else {
        artifacts[existingIndex] = updatedArtifact;
      }

      transaction.set(
        roomDoc,
        {'artifacts': artifacts},
        SetOptions(merge: true),
      );
    });
  }


  void _reportError(String source, Object error, StackTrace stackTrace) {
    if (_disposed) return;

    final detail = error is FirebaseException
        ? error.message ?? error.code
        : error.toString();
    _errorMessage = '$source: $detail';
    debugPrint('$_errorMessage\n$stackTrace');
    notifyListeners();
  }
}
