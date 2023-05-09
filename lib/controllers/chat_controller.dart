import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/services/fb_auth_controller.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import '../models/chat_message.dart';

class ChatController extends GetxController {
  final messageContentController = TextEditingController();

  sendMessage(String otherUserId) async {
    ChatMessage message = ChatMessage(
      content: messageContentController.text,
      senderId: FbAuthController().getCurrentUser(),
    );
    await FirestoreHelper.fireStoreHelper.sendMessage(message, otherUserId);
  }
}
