import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:net/provider/const.dart';
import 'package:net/provider/model.dart';

class HomeaApi {
  static const now_playing =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constant.api}';
  Future<List<Mylist>> getcomingsoon() async {
    final response = await http.get(Uri.parse(now_playing));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'] as List;
      print(data);
      return data
          .map((e) => Mylist(
              poster_path: e['poster_path'],
              original_title: e['original_title'],
              backdrop_path: e['backdrop_path'],
              overview: e['overview'],
              release_date: e['release_date']))
          .toList();
    } else {
      throw Exception("somthing went wrong");
    }
  }
}
