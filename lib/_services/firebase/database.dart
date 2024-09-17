import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../firebase_options.dart';
import '_helpers/helpers.dart';

CloudData cloudService = CloudData();

class CloudData {
  static const String spacesUrl = 'https://sayaritables.europe-west1.firebasedatabase.app/';
  static const String usersUrl = 'https://sayariusers.europe-west1.firebasedatabase.app/';
  static const String defaultUrl = 'https://getsayari-default-rtdb.europe-west1.firebasedatabase.app/';
  static const String sharedUrl = 'https://sayarishared.europe-west1.firebasedatabase.app/';

  final Map<String, DatabaseReference> refs = {
    'default': FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: defaultUrl).ref(),
    'users': FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: usersUrl).ref(),
    'spaces': FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: spacesUrl).ref(),
    'shared': FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: sharedUrl).ref(),
  };

  DatabaseReference ref(String db) {
    return refs[db] ?? FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: usersUrl).ref();
  }

  Future<void> writeData(String path, var data, {required String db}) async {
    await ref(db).child(path).set(data);
  }

  Future<void> updateData(String path, var data, {required String db}) async {
    await ref(db).child(path).update(data);
  }

  Future<void> deleteData(String path, {required String db}) async {
    await ref(db).child(path).remove();
  }

  Future<DataSnapshot> getData(String path, {required String db}) async {
    DataSnapshot snapshot = await ref(db).child(path).get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAfter(String path, String start, {required String db}) async {
    DataSnapshot snapshot = await ref(db).child(path).orderByKey().startAfter(start).get();
    return snapshot;
  }

  Future<DataSnapshot> getDataStartAt(String path, String start, {required String db}) async {
    DataSnapshot snapshot = await ref(db).child(path).orderByKey().startAt(start).get();
    return snapshot;
  }

  Future<String> doesUserExist(String email) async {
    DataSnapshot snapshot = await ref('default').child('users/${emailAsKey(email)}').get();

    return snapshot.value != null ? snapshot.value as String : '';
  }

  Future<void> close() async {
    await FirebaseDatabase.instance.goOffline();
  }

  Future<Map> timestamp() async {
    return ServerValue.timestamp;
  }
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
