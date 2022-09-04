import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'permission.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_stroop/utils/permission.dart';

Future<Directory> getDir() async {
  Directory dir;
  try {
    if (Platform.isAndroid) {
      if (await requsetPermission(Permission.storage)) {
        dir = await getExternalStorageDirectory();
      } else {
        return null;
      }
    } else {
      dir = await getApplicationSupportDirectory();
    }
  } catch (e) {
    //TODO: handle
    dir = await getApplicationSupportDirectory();
  }
  return dir;
}
