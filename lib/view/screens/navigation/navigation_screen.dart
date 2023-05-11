import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/constants/constants.dart';
import 'package:helth_care_doctor/controllers/auth_controller.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';
import 'package:helth_care_doctor/core/global.dart';
import 'package:helth_care_doctor/routes/routes.dart';
import 'package:helth_care_doctor/view/screens/navigation/chat_screen.dart';
import 'package:helth_care_doctor/view/screens/navigation/home_screen.dart';
import 'package:helth_care_doctor/view/widgets/button_widget.dart';

import '../../../constants/app_styles.dart';
import 'dashboard_screen.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (_) {
        List<String> titles = [
          'نصائح صحية',
          'المحادثات',
          'لوحة التحكم',
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
          drawer: Drawer(
            width: (Get.width / 3) * 2,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: primaryColor,
                    child: Text(
                      Global.user['firstName'],
                      style: const TextStyle(
                          fontFamily: 'Expo',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.person_pin, size: 30),
                    title: Text(
                      '${Global.user['firstName']} ${Global.user['secondName']} ${Global.user['familyName']}',
                      style: const TextStyle(fontFamily: 'Expo', fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    leading: const Icon(Icons.email, size: 30),
                    title: Text(
                      Global.user['email'],
                      style: const TextStyle(fontFamily: 'Expo', fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    leading: const Icon(Icons.phone, size: 30),
                    title: Text(
                      Global.user['phone'],
                      style: const TextStyle(fontFamily: 'Expo', fontSize: 12),
                    ),
                  ),
                  const Spacer(),
                  ButtonWidget(
                    width: Get.width,
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.success,
                        dialogBackgroundColor: primaryColor,
                        title: 'تسجيل الخروج',
                        desc: 'هل أنت متأكد؟',
                        titleTextStyle: getBoldStyle(color: Colors.white, fontSize: 15),
                        descTextStyle: getRegularStyle(color: Colors.white, fontSize: 15),
                        buttonsTextStyle: getRegularStyle(color: Colors.white, fontSize: 15),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        btnOkOnPress: () => AuthController().logout(),
                        btnOkText: 'نعم',
                        btnCancelOnPress: (){},
                        btnCancelText: 'لا',
                      ).show();
                    },
                    color: Colors.red,
                    label: 'تسجيل الخروج',
                  ).paddingSymmetric(horizontal: 25),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          body: IndexedStack(
            index: controller.selectedIndex,
            children: const [
              HomeScreen(),
              ChatScreen(),
              DashboardScreen(),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: 'لوحة التحكم',
              ),
            ],
          ),
        );
      },
    );
  }
}
