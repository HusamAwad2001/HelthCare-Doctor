import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/services/fb_auth_controller.dart';
import 'package:helth_care_doctor/view/widgets/snack.dart';

import '../core/storage.dart';
import '../models/app_user.dart';
import '../models/chat_message.dart';
import '../models/chat_user.dart';
import '../models/notification_model.dart';
import '../models/topic_model.dart';
import '../models/user_view.dart';
import '../routes/routes.dart';
import '../view/widgets/loading_dialog.dart';

class FirestoreHelper {
  static FirestoreHelper fireStoreHelper = FirestoreHelper();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// ------------------------------------------------------------------------

  Future<void> addUserToFirestore(AppUser appUser) async {
    LoadingDialog().dialog();
    await firebaseFirestore
        .collection('doctors')
        .doc(appUser.id)
        .set(appUser.toJson());
    Get.back();
  }

  /// ------------------------------------------------------------------------

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
        'image': topic.image,
        'information': topic.information,
        'infoType': topic.infoType,
        'hidden': false,
        'isSubscribe': false,
      });
      Get.offAllNamed(Routes.navigationScreen);
    } catch (e) {
      Snack().show(type: false, message: e.toString());
    }
  }

  /// Update_Hidden_Topic
  Future<bool> updateHiddenTopic(String topicId, bool isHidden) async {
    try {
      await firebaseFirestore
          .collection('topics')
          .doc(topicId)
          .update({'hidden': isHidden});
      return true;
    } catch (e) {
      Snack().show(type: false, message: e.toString());
      return false;
    }
  }

  /// Update_One_Topic
  Future<void> updateTopic(TopicModel topic) async {
    try {
      await firebaseFirestore
          .collection('topics')
          .doc(topic.id)
          .update(topic.toJson());
      Get.offAllNamed(Routes.navigationScreen);
    } catch (e) {
      Snack().show(type: false, message: e.toString());
    }
  }

  /// Delete_One_Topic
  Future<void> deleteTopic(TopicModel topic) async {
    await firebaseFirestore.collection('topics').doc(topic.id).delete();
  }

  /// ------------------------------------------------------------------------

  Future<List<NotificationModel>> getAllSubscriber(String topicId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('topics')
              .doc(topicId)
              .collection('subscriptions')
              .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          querySnapshot.docs;
      List<NotificationModel>? subscribers = documents.map((e) {
        return NotificationModel.fromJson(e.data());
      }).toList();
      return subscribers;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
    return [];
  }

  /// ------------------------------------------------------------------------

  /// Get_All_Doctors
  Future<List<ChatUser>> getAllDoctors() async {
    QuerySnapshot<Map<String, dynamic>> results =
        await firebaseFirestore.collection('doctors').get();
    List<ChatUser> users = results.docs.map((e) {
      return ChatUser.fromMap(e.data());
    }).toList();
    users.removeWhere(
      (element) => element.id == FbAuthController().getCurrentUser(),
    );
    return users;
  }

  /// ------------------------------------------------------------------------

  /// Get_All_Clients
  Future<List<ChatUser>> getAllClients() async {
    QuerySnapshot<Map<String, dynamic>> results =
        await firebaseFirestore.collection('clients').get();
    List<ChatUser> users = results.docs.map((e) {
      return ChatUser.fromMap(e.data());
    }).toList();
    users.removeWhere(
      (element) => element.id == FbAuthController().getCurrentUser(),
    );
    return users;
  }

  /// ------------------------------------------------------------------------

  String getChatId(String otherId) {
    String myId = FbAuthController().getCurrentUser();
    int myHashCode = myId.hashCode;
    int otherHashCode = otherId.hashCode;
    String collectionId =
        myHashCode > otherHashCode ? '$myId$otherId' : '$otherId$myId';
    return collectionId;
  }

  sendMessage(ChatMessage message, String otherUserId) async {
    String collectionId = getChatId(otherUserId);
    firebaseFirestore
        .collection('chats')
        .doc(collectionId)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<ChatMessage>> getAllChatMessage(String otherUserId) {
    String collectionId = getChatId(otherUserId);
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = firebaseFirestore
        .collection('chats')
        .doc(collectionId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
    return stream.map((event) {
      List<ChatMessage> messages = event.docs.map((e) {
        return ChatMessage.fromMap(e.data());
      }).toList();
      return messages;
    });
  }

  /// ------------------------------------------------------------------------

  void addLike(String topicId, bool liked) {
    liked = !liked;
    if (liked) {
      DocumentReference ref = firebaseFirestore
          .collection('topics')
          .doc(topicId)
          .collection('likedUsers')
          .doc(FbAuthController().getCurrentUser());
      ref.set({
        'uid': FbAuthController().getCurrentUser,
        'createdAt': DateTime.now(),
      });
    } else {
      DocumentReference ref = firebaseFirestore
          .collection('topics')
          .doc(topicId)
          .collection('likedUsers')
          .doc(FbAuthController().getCurrentUser());
      ref.delete();
    }
  }

  /// ----------------------------------------------------------------------

  Future<void> getClientInfoById() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> document = await firebaseFirestore
          .collection('doctors')
          .doc(FbAuthController().getCurrentUser())
          .get();
      await Storage.instance.write('user', document.data()!);
      Storage.getData();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  /// ----------------------------------------------------------------------

  /// Add_View
  Future<List<UserView>> getViews(TopicModel topic) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('topics')
              .doc(topic.id)
              .collection('views')
              .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          querySnapshot.docs;
      List<UserView>? usersView = documents.map((e) {
        print(e.data());
        return UserView.fromJson(e.data());
      }).toList();
      return usersView;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
    return [];
  }
}
