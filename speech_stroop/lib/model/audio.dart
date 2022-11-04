import "package:speech_stroop/utils/no_import.dart"
    if (dart.library.ffi) "dart:ffi";
import 'dart:io';
import 'package:http_parser/http_parser.dart';
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
  Audio req = Audio(directory, dateTime);
  var res = await http.post(Uri.parse("${APIPath.baseUrl}/upload/stroop_audio"),
      headers: {
        'Content-Type': 'application/json',
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

Future<String> uploadFile(
  String directory,
  String dateTime,
  String feedback,
  int sectionNumber,
) async {
  String audioUrls;
  // sectionNumber is index of array so we need to plus 1 to convert it to human format
  sectionNumber = sectionNumber + 1;
  var postUri = Uri.parse("${APIPath.baseUrl}/upload/stroop_audio");
  var request = new http.MultipartRequest("POST", postUri);
  try {
    request.files.add(await http.MultipartFile.fromPath(
      "audioFile",
      "${directory}/${feedback}_${dateTime}_section-${sectionNumber}.wav",
      contentType: MediaType('audio', 'x-wav'),
    ));

    var res = await request.send();
    if (res.statusCode == 200) {
      audioUrls = "${feedback}_${dateTime}_section-${sectionNumber}.wav";
    } else {
      audioUrls = "api_error";
    }
  } catch (e) {
    print("Audio.uploadFile error");
    print(e);
  }

  return audioUrls;
}
