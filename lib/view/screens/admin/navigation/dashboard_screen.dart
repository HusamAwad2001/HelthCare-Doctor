import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/controllers/auth_controller.dart';

class DashboardScreen extends GetView<AuthController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () => controller.logout(),
          child: Text('تسجيل خروج'),
        ),
      ),
    );
  }
}
