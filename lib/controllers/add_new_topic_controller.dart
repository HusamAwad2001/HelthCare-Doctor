import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../models/topic_model.dart';
import '../services/firestore_helper.dart';
import '../services/storage_helper.dart';
import '../view/widgets/snack.dart';

class AddNewTopicController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  Future<void> pickImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageFile = File(_pickedFile!.path);
    } else {
      Get.snackbar('انتبه', 'من فضلك قم بإختيار صورة من المعرض');
    }
    update();
  }

  Future<void> addNewTopic() async {
    LoadingDialog().dialog();
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await StorageHelper.instance.uploadImage(imageFile!);
    }
    TopicModel newTopic = TopicModel(
      title: titleController.text,
      description: descriptionController.text,
      logo: 'logo',
      image: imageUrl!,
    );
    await FirestoreHelper.fireStoreHelper.addNewTopic(newTopic);
    titleController.clear();
    descriptionController.clear();
    Get.back();
    update();
  }

  validate() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (imageFile != null) {
      if (titleController.text.isNotEmpty) {
        if (descriptionController.text.isNotEmpty) {
          addNewTopic();
        } else {
          Snack().show(type: false, message: 'يجب إضافة الوصف');
        }
      } else {
        Snack().show(type: false, message: 'يجب إضافة العنوان');
      }
    } else {
      Snack().show(type: false, message: 'يجب إختيار صورة');
    }
  }
}
