import 'package:animate_do/animate_do.dart';
import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FadeInDown(
            onFinish: (direction) {
              Future.delayed(
                Duration(seconds: 4),
                () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushReplacementNamed(context, RouteName.layout);
                  } else
                    Navigator.pushReplacementNamed(context, RouteName.start);
                },
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(AppAssets.logoEventle)],
            ),
          ),
        ),
      ),
    );
  }
}
