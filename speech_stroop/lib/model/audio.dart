import 'package:http/http.dart' as http;
import 'package:speech_stroop/constants.dart';
import 'dart:convert';

import 'package:speech_stroop/model/auth.dart';

class Audio {
  String directory;
  String dateTime;

  Audio(
    this.directory,
    this.dateTime,
  );

  factory Audio.fromJson(dynamic json) {
    return Audio(
      json['directory'] as String,
      json['dateTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "directory": directory,
      "dateTime": dateTime,
    };
  }
}

class AudioUrls {
  List<String> urls;

  AudioUrls(
    this.urls,
  );

  factory AudioUrls.fromJson(dynamic json) {
    List<String> urls =
        json['urls'] != null ? List<String>.from(json['urls']) : [];

    return AudioUrls(
      urls,
    );
  }
}

Future<AudioUrls> uploadAudio(String directory, String dateTime) async {
  AudioUrls audioUrls;
  String token = auth.token;
  Audio req = Audio(directory, dateTime);
  var res = await http.post(Uri.parse("${APIPath.baseUrl}/upload/stroop_audio"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(req));

  print("/upload/stroop_audio " + res.statusCode.toString());

  if (res.statusCode == 200) {
    audioUrls = AudioUrls.fromJson(jsonDecode(res.body));
  } else {
    //TODO: handle
  }

  return audioUrls;
}
