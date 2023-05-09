import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../core/storage.dart';

class DashboardScreen extends GetView<AuthController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () async{
            await Storage.instance.remove('user');
            await Storage.instance.remove('isLogged');
          },
          child: Text('DashboardScreen'),
        ),
      ),
    );
  }
}
