import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/app_user.dart';
import '../view/widgets/loading_dialog.dart';

class FirestoreHelper {
  static FirestoreHelper fireStoreHelper = FirestoreHelper();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUserToFirestore(AppUser appUser) async {
    LoadingDialog().dialog();
    await firebaseFirestore
        .collection('doctors')
        .doc(appUser.id)
        .set(appUser.toJson());
    Get.back();
  }
}