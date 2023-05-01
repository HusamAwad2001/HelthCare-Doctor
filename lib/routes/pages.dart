import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/routes/routes.dart';
import 'package:helth_care_doctor/view/screens/auth/login_screen.dart';
import 'package:helth_care_doctor/view/screens/auth/register_screen.dart';
import 'package:helth_care_doctor/view/screens/welcome_screen.dart';

class Pages {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: Routes.welcomeScreen,
        page: () => const WelcomeScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.registerScreen,
        page: () => RegisterScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.loginScreen,
        page: () => LoginScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
    ];
  }
}
