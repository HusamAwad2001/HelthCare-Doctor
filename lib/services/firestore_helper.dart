import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/app_user.dart';
import '../models/topic_model.dart';
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
}