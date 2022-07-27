import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/add_player_page.dart';
import 'package:http/http.dart' as http;
import '../models/player.dart';

class Players with ChangeNotifier {
  List<Player> _allPlayer = [];
  List<Player> get allPlayer => _allPlayer;
  int get jumlahPlayer => _allPlayer.length;

  Player selectById(String id) =>
      _allPlayer.firstWhere((element) => element.id == id);

  Future<void> addPlayer(String name, String position, String image) {
    DateTime datetimeNow = DateTime.now();
    Uri url = Uri.parse(
        "https://api-accounting-89626-default-rtdb.asia-southeast1.firebasedatabase.app/player.json");
    return http
        .post(url,
            body: json.encode({
              "name": name,
              "position": position,
              "image": image,
              "createdAt": datetimeNow.toString()
            }))
        .then((response) {
      // print(response);
      _allPlayer.add(Player(
          position: position,
          id: json.decode(response.body)["name"].toString(),
          imageUrl: image,
          name: name,
          createdAt: datetimeNow));
      notifyListeners();
    });
  }

  void editPlayer(String id, String name, String position, String image,
      BuildContext context) {
    Player selectPlayer = _allPlayer.firstWhere((element) => element.id == id);
    selectPlayer.name = name;
    selectPlayer.position = position;
    selectPlayer.imageUrl = image;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("berhasil diubah"),
      duration: Duration(seconds: 2),
    ));
    notifyListeners();
  }

  void deletePlayer(String id, BuildContext context) {
    _allPlayer.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("berhasil delete"),
      duration: Duration(seconds: 2),
    ));
    notifyListeners();
  }
}
