import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/models/user_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserView userView = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'الصفحة الشخصية',
          style: TextStyle(
            fontFamily: 'Expo',
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.person_pin, size: 50),
            title: Text(
              userView.name,
              style: const TextStyle(fontFamily: 'Expo'),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.keyboard_hide, size: 50),
            title: Text(
              userView.uid,
              style: const TextStyle(fontFamily: 'Expo'),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.email, size: 50),
            title: Text(
              userView.email,
              style: const TextStyle(fontFamily: 'Expo'),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.phone, size: 50),
            title: Text(
              userView.phone,
              style: const TextStyle(fontFamily: 'Expo'),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.timer, size: 50),
            title: Text(
              userView.dateTime.toString(),
              style: const TextStyle(fontFamily: 'Expo'),
            ),
          ),
        ],
      ),
    );
  }
}
