import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(
        "mongodb+srv://dbUser:dbUserPassword@stroop.4ahnr.mongodb.net/SpeechStroop?retryWrites=true&w=majority");
    await db.open();
    // db.collection('User').insert({'name': 'Mali'});
    var userCollection =
        await db.collection('User').find({'name': 'Mali'}).toList();
    print(userCollection);
  }
}
