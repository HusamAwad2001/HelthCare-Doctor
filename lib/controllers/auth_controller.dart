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

  String typeOfInAccount = "doctor";

  void login() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await FbAuthController().signIn(
      email: loginEmailController.text.trim(),
      password: loginPasswordController.text.trim(),
    ).then((value) {
      clear();
      // Snack().show(type: true, message: 'تم تسجيل الدخول بنجاح');
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
        'typeOfInAccount': typeOfInAccount,
      };
      Storage.instance.write("isLogged", Global.isLogged);
      Storage.instance.write("user", Global.user);
      // Global.user['typeOfInAccount'] == 'doctor'
      //     ? Get.offAllNamed(Routes.navigationScreen)
      //     : Get.offAllNamed(Routes.patentsNavigationScreen);
      Get.offAllNamed(Routes.navigationScreen);


    });
    update();
  }

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await FbAuthController().createAccount(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((value) async{
      await FirestoreHelper.fireStoreHelper.addUserToFirestore(
        AppUser(
          id: FbAuthController().getCurrentUser(),
          firstName: firstNameController.text.trim(),
          secondName: secondNameController.text.trim(),
          familyName: familyNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          address: addressController.text.trim(),
          birthDate: birthDateController.text.trim(),
          password: passwordController.text.trim(),
          typeOfInAccount: typeOfInAccount,
        ),
      );
      clear();
      Snack().show(type: true, message: 'تم إنشاء الحساب بنجاح');
      Global.isLogged = true;
      Global.user = {
        'id': FbAuthController().getCurrentUser(),
        'firstName': firstNameController.text.trim(),
        'secondName': secondNameController.text.trim(),
        'familyName': familyNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'birthDate': birthDateController.text.trim(),
        'password': passwordController.text.trim(),
        'typeOfInAccount': typeOfInAccount,
      };
      Storage.instance.write("isLogged", Global.isLogged);
      Storage.instance.write("user", Global.user);
      Get.offAllNamed(Routes.navigationScreen);
    });
    update();
  }

  Future<void> logout() async{
    LoadingDialog().dialog();
    await FbAuthController().signOut();
    await Storage.instance.remove('user');
    await Storage.instance.remove('isLogged');
    Get.offAllNamed(Routes.loginScreen);
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
