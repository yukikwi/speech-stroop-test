import 'dart:convert';

import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/test_module/history.dart';
import 'package:speech_stroop/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class Auth {
  String _id;
  String token;

  Auth(this._id, this.token);

  factory Auth.fromJson(dynamic json) {
    return Auth(json['_id'] as String, json['token'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": _id,
      "token": token,
    };
  }
}

Auth auth;

logout() async {
  String token = auth.token;
  var res = await http.get(
    Uri.parse("${APIPath.baseUrl}/auth/logout"),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  print("get: auth/logout" + res.statusCode.toString());
  //TODO: handle
  if (res.statusCode == 200) {
  } else {}
  userProfile = null;
  userHistory = null;
  testDayStack = Tuple2(DateTime.now(), 0);
}

Future<http.Response> login(String tel, String password) async {
  var res = await http.post(Uri.parse("${APIPath.baseUrl}/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "tel": tel,
        "password": password,
      }));

  if (res.statusCode == 200) {
    auth = Auth.fromJson(jsonDecode(res.body));
    print("login success");
    return res;
  } else {
    print('login failed');
    return res;
  }
}

Future<http.Response> getUserByTel(String tel) async {
  Map<String, String> qParams = {
    'tel': tel,
  };
  final uri =
      Uri.http('speech-stroop.herokuapp.com', '/auth/profile_tel', qParams);
  final res =
      await http.get(uri, headers: {'Content-Type': 'application/json'});

  return res;
}
