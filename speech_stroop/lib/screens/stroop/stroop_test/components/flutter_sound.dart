import 'dart:async';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_stroop/utils/directory.dart';

class RecordAudio {
  int section;
  final String datetime;
  String feedback;
  RecordAudio(this.section, this.datetime, this.feedback);
  // compress file with tSampleRate
  int tSampleRate = 6000;
  FlutterSoundRecorder mRecorder = FlutterSoundRecorder();
  bool mRecorderIsInited = false;
  String pcmPath;
  StreamSubscription mRecordingDataSubscription;
  bool isRecording = false;

  Future<String> getFilePathWAV() async {
    var tempDir = await getDir();
    var fileName = getFileName();
    print('${tempDir.path}/$fileName.wav');
    return '${tempDir.path}/$fileName.wav';
  }

  Future<String> getFilePathPCM() async {
    var tempDir = await getDir();
    var fileName = getFileName();
    print('${tempDir.path}/$fileName.pcm');
    return '${tempDir.path}/$fileName.pcm';
  }

  String getFileName() {
    return '${feedback}_${datetime}_section-$section';
  }

  Future<IOSink> createFile() async {
    pcmPath = await getFilePathPCM();
    var outputFile = File(pcmPath);
    if (outputFile.existsSync()) {
      await outputFile.delete();
    }
    return outputFile.openWrite();
  }

  Future<void> openRecorder() async {
    await mRecorder.openRecorder();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    mRecorderIsInited = true;
  }

  // @override
  // void dispose() {
  //   stopRecorder();
  //   mRecorder.closeRecorder();
  //   mRecorder = null;
  //   super.dispose();
  // }

  Future<void> record() async {
    print("startRecorder");
    assert(mRecorderIsInited);
    var sink = await createFile();
    var recordingDataController = StreamController<Food>();
    mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) {
      if (buffer is FoodData) {
        sink.add(buffer.data);
      }
    });
    isRecording = true;
    await mRecorder.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
    );
  }

  Future<void> stopRecorder() async {
    print("stopRecorder");
    isRecording = false;
    await mRecorder.stopRecorder();
    if (mRecordingDataSubscription != null) {
      await mRecordingDataSubscription.cancel();
      mRecordingDataSubscription = null;
    }

    String fromURI = pcmPath;
    var wavPath = await getFilePathWAV();

    await flutterSoundHelper.pcmToWave(
      inputFile: fromURI,
      outputFile: wavPath,
      numChannels: 1,
      sampleRate: tSampleRate,
    );
    mRecorder.closeRecorder();
    mRecorder = null;
    print('Recorded success at $wavPath');
  }

  void Function() getRecorderFn() {
    if (!mRecorderIsInited) {
      return null;
    }
    return !isRecording
        ? () async {
            await record();
          }
        : () async {
            await stopRecorder();
          };
  }
}
