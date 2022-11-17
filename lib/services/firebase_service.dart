import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
        msg: e.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

/*Future<void> addUser(String email) {
  // Call the user's CollectionReference to add a new user
  return users
      .add({
        'email': email, // John Doe
        'name': 'John Doe', // Stokes and Sons
        'age': 21 // 42
      })
      .then((value) => print("User Added"))
      .catchError((error) {
        print("Failed to add user: $error");
      });
}*/

bool isUserLoggedIn() {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return true;
  } else {
    return false;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
