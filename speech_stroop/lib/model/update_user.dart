import 'package:http/http.dart' as http;
import 'package:speech_stroop/constants.dart';
import 'dart:convert';

import 'package:speech_stroop/model/auth.dart';
import 'package:speech_stroop/model/precondition.dart';
import 'package:speech_stroop/model/user.dart';

class UpdateUser {
  String tel;
  String username;
  String name;
  String surname;
  String email;
  DateTime dateOfBirth;
  String gender;
  String education;
  Precondition precondition;

  UpdateUser({
    this.tel,
    this.username,
    this.name,
    this.surname,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.education,
    this.precondition,
  });

  factory UpdateUser.fromJson(dynamic json) {
    return UpdateUser(
      tel: json['tel'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String).toLocal(),
      gender: json['gender'] as String,
      education: json['education'] as String,
      precondition: Precondition.fromJson(json['precondition']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tel": tel,
      "username": username,
      "name": name,
      "surname": surname,
      "email": email,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "gender": gender,
      "education": education,
      "precondition": precondition,
    };
  }
}

updateUserProfile(UpdateUser updatedUser) async {
  String token = auth.token;
  print("jsonEncode(updatedUser):" + jsonEncode(updatedUser));
  var res = await http.patch(Uri.parse("${APIPath.baseUrl}/user/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updatedUser));

  print("patch: /user/profile " + res.statusCode.toString());

  //TODO: handle
  if (res.statusCode == 200) {
    print(res.body);
    await getUserProfile(true);
  } else {}

  return updatedUser;
}

updateUserPrecondition(Precondition updatedPreconditionValue) async {
  String token = auth.token;
  var updatePrecondition = {"precondition": updatedPreconditionValue};
  print("jsonEncode(updatedUser):" + jsonEncode(updatePrecondition));
  var res = await http.patch(Uri.parse("${APIPath.baseUrl}/user/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updatePrecondition));

  print("patch: /user/profile " + res.statusCode.toString());

  //TODO: handle
  if (res.statusCode == 200) {
    print(res.body);
    await getUserProfile(true);
  } else {}

  return updatePrecondition;
}

updateUserBadge(List<String> updatedBadgeValue) async {
  String token = auth.token;
  var updateBadge = {"badge": updatedBadgeValue};

  print("jsonEncode(updateBadge):" + jsonEncode(updateBadge));
  //TODO:
  var res = await http.patch(Uri.parse("${APIPath.baseUrl}/user/profile"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updateBadge));

  print("patch: /user/profile " + res.statusCode.toString());

  //TODO: handle
  if (res.statusCode == 200) {
    print(res.body);
    await getUserProfile(true);
  } else {}

  return updateBadge;
}
