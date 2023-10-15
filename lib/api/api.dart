import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:pretest_mdi_pai/data/user_list.dart';

import '../data/user.dart';
import '../model/failure.dart';

class Api {
  //function untuk menampilkan data user
  Future<List<UserList>> searchUser(
      {required String query, int limit = 100}) async {
    final url =
        'https://dummyjson.com/users/search?q=$query&limit=$limit&skip=0';

    print("URL : $url");

    final response = await http.get(Uri.parse(url));

    print(response.body);

    if (response.statusCode == 200) {
      final searchData = json.decode(response.body)['users'] as List;
      inspect(searchData);
      return searchData.map((user) => UserList.fromJson(user)).toList();
    } else {
      throw Exception('Gagal terhubung');
    }
  }

  //function untuk login
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    Map<String, dynamic> result;
    Uri url = Uri.parse('https://dummyjson.com/auth/login');
    Map<String, String> data = {'username': username, 'password': password};
    try {
      var response = await http.post(url,
          body: json.encode(data),
          headers: <String, String>{'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        User user = User.fromJson(json.decode(response.body));
        result = {
          'status': true,
          'message': 'Successfully logged in.',
          'data': user
        };
      } else {
        String message = '${json.decode(response.body)['message']}.';
        result = {
          'status': false,
          'message': 'Logged in failed.',
          'data': Failure(message: message)
        };
      }
    } on SocketException {
      result = {
        'status': false,
        'message': 'Unsuccessful request.',
        'data': Failure(
            message:
                'There is not internet connection, please check your data roaming.')
      };
    }
    return result;
  }
}

