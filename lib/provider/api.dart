import 'package:net/provider/const.dart';
import 'package:net/provider/model.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class Api {
  List<Mylist> _items = []; 
  List<Mylist> get items => _items;

  static const now_playing =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constant.api}';

  Future<List<Mylist>> getlistnowplaying() async {
    final response = await http.get(Uri.parse(now_playing));
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
      return _items;
    } else {
      throw Exception("Something went wrong");
    }
  }

  List<Mylist> search(String value) {
    final displayList = _items
        .where((element) =>
            element.original_title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    return displayList;
  }

  // void searchItems(String value) {}
}
