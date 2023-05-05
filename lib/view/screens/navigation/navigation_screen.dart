import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';
import 'package:helth_care_doctor/view/screens/navigation/chat_screen.dart';
import 'package:helth_care_doctor/view/screens/navigation/home_screen.dart';

import 'dashboard_screen.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex,
            children: const [
              HomeScreen(),
              ChatScreen(),
              DashboardScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: (index) => controller.changeNavigation(index),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: 'الداشبورد',
              ),
            ],
          ),
        );
      },
    );
  }
}
