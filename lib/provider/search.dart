import 'package:flutter/material.dart';
import 'package:net/provider/const.dart';
import 'package:net/provider/model.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class ApiProvider extends ChangeNotifier{
  List<Mylist> _items = [];
  List<Mylist> get items => _items;
  Future<void> getlistnowplaying() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=${Constant.api}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> userlist = json.decode(response.body);
      final List<dynamic> data = userlist['results'];
      _items = data
          .map((e) => Mylist(
                poster_path: e['poster_path'],
                original_title: e['original_title'],
                backdrop_path: e['backdrop_path'],
                overview: e['overview'],
                release_date: e['release_date'],
              ))
          .toList();
      notifyListeners();
    } else {
      throw Exception("Something went wrong");
    }
  }
    search(String word) {
      _items = items
          .where((element) =>
              element.original_title.toLowerCase().contains(word.toLowerCase()))
          .toList();

    notifyListeners();
  }

 searchItems(String val) async {
     await getlistnowplaying();
     search(val);
    notifyListeners();
  }

  
}
