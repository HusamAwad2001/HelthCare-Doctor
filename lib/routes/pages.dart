import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/bindings/navigation_binding.dart';
import 'package:helth_care_doctor/routes/routes.dart';
import 'package:helth_care_doctor/view/screens/admin/auth/login_screen.dart';
import 'package:helth_care_doctor/view/screens/admin/auth/register_screen.dart';
import 'package:helth_care_doctor/view/screens/admin/navigation/home_screen.dart';
import 'package:helth_care_doctor/view/screens/admin/navigation/navigation_screen.dart';
import 'package:helth_care_doctor/view/screens/admin/welcome_screen.dart';

import '../bindings/add_new_topic_binding.dart';
import '../bindings/auth_binding.dart';
import '../bindings/topic_details_binding.dart';
import '../controllers/navigation_controller.dart';
import '../view/screens/admin/add_new_topic.dart';
import '../view/screens/admin/topic_details_screen.dart';
import '../view/screens/user/navigation/patents_navigation_screen.dart';

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
        binding: AuthBinding(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.loginScreen,
        page: () => LoginScreen(),
        binding: AuthBinding(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.navigationScreen,
        page: () => const NavigationScreen(),
        binding: NavigationBinding(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.patentsNavigationScreen,
        page: () => const PatentsNavigationScreen(),
        binding: NavigationBinding(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.homeScreen,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.addNewTopicScreen,
        page: () => const AddNewTopicScreen(),
        binding: AddNewTopicBinding(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
      GetPage(
        name: Routes.topicDetailsScreen,
        page: () => const TopicDetailsScreen(),
        binding: TopicDetailsBinding(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
    ];
  }
}
