import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';
import 'package:helth_care_doctor/view/widgets/snack.dart';

import '../models/app_user.dart';
import '../models/topic_model.dart';
import '../routes/routes.dart';
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

  /// Get_All_Topics
  Future<List<TopicModel>> getAllTopics() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await firebaseFirestore.collection('topics').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          querySnapshot.docs;
      List<TopicModel>? topics = documents.map((e) {
        TopicModel topic = TopicModel.fromJson(e.data());
        topic.id = e.id;
        return topic;
      }).toList();
      return topics;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
    return [];
  }

  /// Add_New_Topic
  Future<void> addNewTopic(TopicModel topic) async {
    try {
      await firebaseFirestore.collection('topics').add({
        'id': '',
        'title': topic.title,
        'description': topic.description,
        'logo': topic.logo,
        'image': topic.image,
      });
      Get.offAllNamed(Routes.navigationScreen);
    } catch (e) {
      Snack().show(type: false, message: e.toString());
    }
  }

  /// Delete_One_Topic
  Future<void> deleteTopic(TopicModel topic) async {
    await firebaseFirestore.collection('topics').doc(topic.id).delete();
  }
}
