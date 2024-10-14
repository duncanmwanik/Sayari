import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../_helpers/extentions/strings.dart';
import '../../firebase_options.dart';

CloudData cloudService = CloudData();

class CloudData {
  static const String spacesUrl = 'https://sayarispaces.europe-west1.firebasedatabase.app/';
  static const String usersUrl = 'https://sayariusers.europe-west1.firebasedatabase.app/';
  static const String defaultUrl = 'https://getsayari-default-rtdb.europe-west1.firebasedatabase.app/';

  final Map<String, DatabaseReference> refs = {
    'default': FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: defaultUrl).ref(),
    'users': FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: defaultUrl).ref(),
    'spaces': FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: defaultUrl).ref(),
  };

  // if you upgrade to blaze, remove the '$db/' and reset the urls in the refs map above

  DatabaseReference ref(String db) {
    return refs[db] ?? FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: usersUrl).ref();
  }

  Stream<DatabaseEvent> listen(String path, {required String db}) {
    return ref(db).child('$db/$path').onValue;
  }

  Future<void> writeData(String path, var data, {required String db}) async {
    await ref(db).child('$db/$path').set(data);
  }

  Future<void> updateData(String path, var data, {required String db}) async {
    await ref(db).child('$db/$path').update(data);
  }

  Future<void> deleteData(String path, {required String db}) async {
    await ref(db).child('$db/$path').remove();
  }

  Future<DataSnapshot> getData(String path, {required String db}) async {
    DataSnapshot snapshot = await ref(db).child('$db/$path').get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAfter(String path, String start, {required String db}) async {
    DataSnapshot snapshot = await ref(db).child('$db/$path').orderByKey().startAfter(start).get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAt(String path, String start, {required String db}) async {
    DataSnapshot snapshot = await ref(db).child('$db/$path').orderByKey().startAt(start).get();
    return snapshot;
  }

  Future<bool> doesSpaceExist(String spaceId) async {
    DataSnapshot snapshot = await ref('spaces').child(spaceId).get();
    return snapshot.value != null;
  }

  Future<String> doesUserExist(String email) async {
    DataSnapshot snapshot = await ref('default').child('emails/${email.naked()}').get();
    return snapshot.value != null ? snapshot.value as String : '';
  }

  Future<void> close() async => await FirebaseDatabase.instance.goOffline();
  Future<Map> timestamp() async => ServerValue.timestamp;
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
