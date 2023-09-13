// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInScreenController extends GetxController {
//   @override
//   void onInit() async {
//     googleSignin();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   authStateChange() {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//   }

//   idTokenChange() async {
//     FirebaseAuth.instance.idTokenChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//   }

//   userChanges() async {
//     FirebaseAuth.instance.userChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//   }

//   signInWithEmailAndPassword() async {
//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: "adrian.tulang@yoooto.io", password: "Fag37206");
//       print("credentials: ${credential.user}");
//       print("username: ${credential.additionalUserInfo!.username}");
//       print("here");
//       await sendEmailVerification();
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }

//   Future<void> sendEmailVerification() async {
//     try {
//       FirebaseAuth.instance.currentUser!.sendEmailVerification();
//     } on FirebaseAuthException catch (e) {
//       print("ERROR $e"); // Display error message
//     }
//   }

//   googleSignin() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
//         var credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth?.accessToken,
//           idToken: googleAuth?.idToken,
//         );
//         print("access token: ${googleAuth?.accessToken}");
//         print("id token: ${googleAuth?.idToken}");

//         UserCredential? userCredential =
//             await FirebaseAuth.instance.signInWithCredential(credential);
//         print(userCredential.user!.email);
//         print(userCredential.user!.displayName);
//         if (userCredential.additionalUserInfo?.username != null) {
//           print("username: ${userCredential.additionalUserInfo?.username}");
//           print("profile: ${userCredential.additionalUserInfo?.profile}");
//         } else {
//           print("null ang user credentials");
//         }
//       } else {
//         print("null ang access token ug idtoken");
//       }
//     } catch (e) {
//       print("ERROR: $e");
//     }
//   }
// }
