import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/services/fb_auth_controller.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';

import '../core/global.dart';
import '../core/storage.dart';
import '../models/app_user.dart';
import '../routes/routes.dart';
import '../view/widgets/snack.dart';

class AuthController extends GetxController {
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final familyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final birthDateController = TextEditingController();
  final passwordController = TextEditingController();

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  void login() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await FbAuthController().signIn(
      email: loginEmailController.text.trim(),
      password: loginPasswordController.text.trim(),
    ).then((value) {
      clear();
      Snack().show(type: true, message: 'تم تسجيل الدخول بنجاح');
    });
    update();
  }

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await FirestoreHelper.fireStoreHelper.addUserToFirestore(
      AppUser(
        firstName: firstNameController.text.trim(),
        secondName: secondNameController.text.trim(),
        familyName: familyNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        birthDate: birthDateController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
    await FbAuthController().createAccount(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((value) {
      clear();
      Snack().show(type: true, message: 'تم إنشاء الحساب بنجاح');
      Global.isLogged = true;
      Global.user = {
        'firstName': firstNameController.text.trim(),
        'secondName': secondNameController.text.trim(),
        'familyName': familyNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'birthDate': birthDateController.text.trim(),
        'password': passwordController.text.trim(),
      };
      Storage.instance.write("isLogged", Global.isLogged);
      Storage.instance.write("user", Global.user);
      Get.offAllNamed(Routes.homeScreen);
    });
    update();
  }

  void clear() {
    firstNameController.clear();
    secondNameController.clear();
    familyNameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    birthDateController.clear();
    passwordController.clear();
  }
}