import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_yalla_harek/games/models/game_model.dart';

class FireStoreService {
  final _fire = FirebaseFirestore.instance;

  Future<void> newGame(GameModel game) async {
    try {
      await _fire.collection("games").add(game.toJson());
    } catch (e, s) {
      log('$e - $s');
    }
  }

  Future<bool> deleteGame(GameModel game) async {
    try {
      await _fire.collection("games").doc(game.id).delete();
      return true;
    } catch (e, s) {
      log('$e - $s');
      return false;
    }
  }

  Stream<List<GameModel?>?> getGames() {
    return _fire.collection('games').snapshots().map((snapShot) => snapShot.docs
        .map((document) => GameModel.fromJson(document.id, document.data()))
        .toList());
  }
}
