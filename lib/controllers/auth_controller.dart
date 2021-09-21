import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_app_firebase/constants/firebase.dart';
import 'package:e_commerce_app_firebase/models/user_model.dart';
import 'package:e_commerce_app_firebase/screens/authentication/authentication_screen.dart';
import 'package:e_commerce_app_firebase/screens/home/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  String usersCollection = "users";
  Rx<UserModel?> userModel = UserModel().obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onReady() {
    // instantiate firebase user
    firebaseUser = Rx<User?>(auth.currentUser);
    // listen to authentication changes
    // listen if user is loggedin or not
    firebaseUser.bindStream(auth.userChanges());
    // setup event triggers
    // listens to changes in firebaseUser
    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => AuthenticationScreen());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => HomeScreen());
    }
  }

  void signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
          "Sign In Failed", "Invalid email and/or password. Please try again.");
    }
  }

  void signUp() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        print(result);
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _clearTextEditingControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
          "Sign Up Failed", "Please enter a valid email and/or password.");
    }
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.trim(),
      "cart": []
    });
  }

  _clearTextEditingControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  void signOut() async {
    await auth.signOut();
  }

  updateUserData(Map<String, dynamic> data) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
