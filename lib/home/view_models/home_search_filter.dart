import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/games/models/game_model.dart';

class HomeSearchSort extends ChangeNotifier {
  String _search = '';
  int _sort = 0;

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  int get sort => _sort;
  set sort(int value) {
    _sort = value;
    notifyListeners();
  }

  List<GameModel?>? searchAndSort(List<GameModel?>? games) {
    if (games == null) return null;
    
    var temp = games
        .where((element) => element?.title.contains(search) == true)
        .toList();
    temp.sort((a, b) {
      if (sort == 0) {
        return b?.title.toLowerCase().compareTo(a!.title.toLowerCase()) ?? 0;
      }
      if (sort == 1) {
        return b?.dateTime.compareTo(a!.dateTime) ?? 0;
      }
      return 0;
    });
    return temp;
  }
}
