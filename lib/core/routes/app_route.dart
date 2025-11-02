import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/auth/pages/Forget_Password_screen.dart';
import 'package:evently/module/auth/pages/Regist_screen.dart';
import 'package:evently/module/auth/pages/login_screen.dart';
import 'package:evently/module/event/pages/add_event_screen.dart';
import 'package:evently/module/event/pages/edit_event.dart';
import 'package:evently/module/event/pages/event_details.dart';
import 'package:evently/module/layout/pages/layout_screen.dart';

import 'package:evently/module/onboarding/pages/onboarding_screen.dart';
import 'package:evently/module/splash/pages/splash_screen.dart';
import 'package:evently/module/start_screen/pages/start_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoute{
  AppRoute._();
  static Map<String, Widget Function(BuildContext)> routes ={
    RouteName.splash:(_)=>SplashScreen(),
    RouteName.start:(_)=>StartScreen(),
    RouteName.OnBoarding:(_)=>OnboardingScreen(),
    RouteName.Login:(_)=>LoginScreen(),
    RouteName.register:(_)=>RegistScreen(),
    RouteName.forget:(_)=>ForgetPasswordScreen(),
    RouteName.layout:(_)=>LayoutScreen(),
    RouteName.addEvent:(_)=>AddEventScreen(),
    RouteName.eventDetails:(_)=>Eventdetails(),
    RouteName.eventEdit:(_)=>EditEvent(),

  };
}