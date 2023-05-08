import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/constants/constants.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';
import 'package:helth_care_doctor/routes/routes.dart';
import 'package:helth_care_doctor/view/screens/admin/navigation/chat_screen.dart';
import 'package:helth_care_doctor/view/screens/admin/navigation/home_screen.dart';

class PatentsNavigationScreen extends GetView<NavigationController> {
  const PatentsNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (_) {
        List<String> titles = [
          'نصائح صحية',
          'المحادثات',
        ];
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              titles[controller.selectedIndex],
              style: const TextStyle(
                fontFamily: 'Expo',
              ),
            ),
          ),
          body: IndexedStack(
            index: controller.selectedIndex,
            children: const [
              HomeScreen(),
              ChatScreen(),
            ],
          ),
          floatingActionButton: controller.selectedIndex == 0
              ? FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () => Get.toNamed(Routes.addNewTopicScreen),
                  child: const Icon(Icons.add),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: (index) => controller.changeNavigation(index),
            selectedLabelStyle: const TextStyle(fontFamily: 'Expo'),
            unselectedLabelStyle: const TextStyle(fontFamily: 'Expo'),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                activeIcon: Icon(Icons.chat),
                label: 'المحادثات',
              ),
            ],
          ),
        );
      },
    );
  }
}
