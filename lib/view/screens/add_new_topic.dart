import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/controllers/add_new_topic_controller.dart';

import '../../constants/constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';

class AddNewTopicScreen extends GetView<AddNewTopicController> {
  const AddNewTopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'إضافة عنوان',
          style: TextStyle(
            fontFamily: 'Expo',
          ),
        ),
      ),
      body: GetBuilder<AddNewTopicController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: GetBuilder<AddNewTopicController>(
                    builder: (_) {
                      return controller.imageFile != null
                          ? CircleAvatar(
                              radius: 75,
                              backgroundImage: FileImage(controller.imageFile!),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    controller.imageFile != null
                                        ? Icons.edit
                                        : Icons.camera_alt_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/hint_person.png'),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                TextFieldWidget(
                  controller: controller.titleController,
                  hintText: 'العنوان',
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  controller: controller.descriptionController,
                  hintText: 'الوصف',
                ),
                const SizedBox(height: 60),
                ButtonWidget(
                  width: double.infinity,
                  label: 'إضافة',
                  onPressed: () => controller.validate(),
                ),
              ],
            ).marginSymmetric(horizontal: 28),
          );
        },
      ),
    );
  }
}
