// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:google_sign_in/google_sign_in.dart';

// Future<UserCredential>

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../_helpers/_common/global.dart';

Future<void> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  printThis(googleUser?.email);
  printThis(googleUser?.displayName);
  printThis(credential.idToken);
  printThis(credential.providerId);

  // Once signed in, return the UserCredential
  // return await FirebaseAuth.instance.signInWithCredential(credential);
}
