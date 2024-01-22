import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hr_module/firebase/constants.dart';

class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
          .signIn();


      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(
            credential);

        final User? user = authResult.user;
        return user;
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
      return null;
    }
  }

  Future<void> handleSignIn() async {
    final User? user = await signInWithGoogle();

    if (user != null) {
      print('Signed in with Google: ${user.displayName}');
      // Navigate to the next page or perform other actions
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => ()));
    } else {
      print('Failed to sign in with Google');
    }
  }
}



