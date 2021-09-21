import 'package:e_commerce_app_firebase/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
              onPressed: () async {
                authController.signOut();
              },
              child: Text("Logout")),
        ),
      ),
    );
  }
}
