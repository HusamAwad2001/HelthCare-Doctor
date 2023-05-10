import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../core/storage.dart';
import '../../../core/global.dart';

class DashboardScreen extends GetView<NavigationController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () async{
            // await Storage.instance.remove('user');
            // await Storage.instance.remove('isLogged');
            await controller.sendNotification(
              to: 'cu6hDe0ySPmOcTlX4IQ3vv:APA91bFMfWqsysa1z7VoUpCkf0NcED2aGSLfJMIPIVJs-Om_HHD92wK2Wgs9i7mtN4uun9Tq3BpvhFfG6GHBqUvuDeN4f-Vm-LoONQ0OTuaQ7-i91F07pLKCz2xsvp5IroHm6654Gj3c',
              title: 'HHHH',
              body: 'BBBBB',
            ).then((value) {
            print('sss');
            }).catchError((error) {
              print('Error: ${error.toString()}');
            });
          },
          child: Text('DashboardScreen'),
        ),
      ),
    );
  }
}
