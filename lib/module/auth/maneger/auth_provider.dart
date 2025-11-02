import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/firebase_manger/firebase_auth_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserCredential? user;

  Future<void> createAccount(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        user = await firebaseAuthManger.createAccount(
          emailController.text,
          passwordController.text,
          nameController.text,
        );

        if (user?.user != null) {
          Navigator.pushReplacementNamed(context, RouteName.layout);
          showCustomSnackBar(context, "Welcome ${user?.user?.displayName ?? ""}");

          nameController.clear();
          emailController.clear();
          passwordController.clear();
          rePasswordController.clear();
        }
      } catch (e) {
        showCustomSnackBar(context, "Error: ${e.toString()}", isError: true);
      }
    } else {
      showCustomSnackBar(context, "Invalid data. Please check your inputs.", isError: true);
    }

    notifyListeners();
  }

  Future<void> login(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        user = await firebaseAuthManger.login(
          emailController.text,
          passwordController.text,
        );

        if (user?.user != null) {
          Navigator.pushReplacementNamed(context, RouteName.layout);
          showCustomSnackBar(context, "Welcome ${user?.user?.displayName ?? ""}");


          emailController.clear();
          passwordController.clear();
        }
      } catch (e) {
        showCustomSnackBar(context, "Login failed: ${e.toString()}", isError: true);
      }
    } else {
      showCustomSnackBar(context, "Invalid Email or Password", isError: true);
    }

    notifyListeners();
  }

  Future<void> resetPassword(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        await firebaseAuthManger.resetPassword(emailController.text);
        showCustomSnackBar(context, "Password reset link sent!");
      } catch (e) {
        showCustomSnackBar(context, "Error: ${e.toString()}", isError: true);
      }
    } else {
      showCustomSnackBar(context, "Enter a valid email", isError: true);
    }
  }

  void showCustomSnackBar(BuildContext context, String message, {bool isError = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isError ? Colors.red : AppColor.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(message, style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          closeIconColor: Colors.white,
          showCloseIcon: true,
        ),
      );
    });
  }
}
