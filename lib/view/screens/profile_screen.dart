import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/models/user_view.dart';
import 'package:intl/intl.dart';

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
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.person_pin, size: 40),
            title: Text(
              userView.name,
              style: const TextStyle(fontFamily: 'Expo', fontSize: 14),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email, size: 40),
            title: Text(
              userView.email,
              style: const TextStyle(fontFamily: 'Expo', fontSize: 14),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone, size: 40),
            title: Text(
              userView.phone,
              style: const TextStyle(fontFamily: 'Expo', fontSize: 14),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.timer, size: 40),
            title: Text(
              DateFormat.yMd().format(DateTime.parse(userView.dateTime)),
              style: const TextStyle(fontFamily: 'Expo', fontSize: 14),
            ),
            subtitle: Text(
              DateFormat.jm().format(DateTime.parse(userView.dateTime)),
              style: const TextStyle(fontFamily: 'Expo', fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
