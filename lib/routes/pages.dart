import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/bindings/navigation_binding.dart';
import 'package:helth_care_doctor/routes/routes.dart';
import 'package:helth_care_doctor/view/screens/auth/login_screen.dart';
import 'package:helth_care_doctor/view/screens/auth/register_screen.dart';
import 'package:helth_care_doctor/view/screens/chat_message_screen.dart';
import 'package:helth_care_doctor/view/screens/navigation/home_screen.dart';
import 'package:helth_care_doctor/view/screens/navigation/navigation_screen.dart';
import 'package:helth_care_doctor/view/screens/welcome_screen.dart';

import '../bindings/add_new_topic_binding.dart';
import '../bindings/auth_binding.dart';
import '../bindings/topic_details_binding.dart';
import '../bindings/chat_binding.dart';
import '../bindings/update_topic_binding.dart';
import '../view/screens/add_new_topic.dart';
import '../view/screens/topic_details_screen.dart';
import '../view/screens/update_topic_screen.dart';

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
        name: Routes.updateTopicScreen,
        page: () => const UpdateTopicScreen(),
        binding: UpdateTopicBinding(),
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
      GetPage(
        name: Routes.chatScreen,
        page: () => ChatMessageScreen(),
        binding: ChatBinding(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      ),
    ];
  }
}
