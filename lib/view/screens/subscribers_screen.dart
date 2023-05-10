import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';
import 'package:helth_care_doctor/models/notification_model.dart';
import 'package:helth_care_doctor/view/widgets/empty_list.dart';

import '../../constants/app_styles.dart';
import '../../constants/constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/snack.dart';
import '../widgets/text_field_widget.dart';

class SubscribersScreen extends GetView<NavigationController> {
  const SubscribersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> list = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'المشتركين',
          style: TextStyle(
            fontFamily: 'Expo',
          ),
        ),
      ),
      body: list.isEmpty
          ? const EmptyList(text: 'لا يوجد مشتركين')
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                final item = list[index];
                return GestureDetector(
                  onTap: () async {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 1,
                        color: primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'Expo'),
                      ),
                      subtitle: Text(
                        item.phone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Expo',
                          fontSize: 12,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () async{
                          Get.dialog(
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Scaffold(
                                backgroundColor:
                                Colors.transparent,
                                body: Container(
                                  color: primaryColor
                                      .withOpacity(0.2),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'إرسال إشعار إلى\n "${controller.filteredTopics.isEmpty
                                            ? item.name
                                            : controller.filteredTopics[index]
                                            .title}"',
                                        textAlign: TextAlign.center,
                                        style:
                                        getRegularStyle().copyWith(height: 1.5),
                                      ),
                                      const SizedBox(
                                          height: 20),
                                      TextFieldWidget(
                                        controller: controller.titleController,
                                        hintText:
                                        'عنوان الإشعار',
                                      ),
                                      const SizedBox(
                                          height: 10),
                                      TextFieldWidget(
                                        controller: controller.bodyController,
                                        hintText: 'وصف الإشعار',
                                      ),
                                      const SizedBox(
                                          height: 20),
                                      ButtonWidget(
                                        label: 'إرسال',
                                        onPressed: () async{
                                          if(controller.titleController.text.isEmpty){
                                            Snack().show(type: false, message: 'قم بكتابة عنوان الإشعار');
                                          } else if(controller.bodyController.text.isEmpty){
                                            Snack().show(type: false, message: 'قم بكتابة وصف الإشعار');
                                          } else{
                                            await controller.sendNotification(
                                            to: item.deviceToken,
                                            title: controller.titleController.text,
                                            body: controller.bodyController.text,
                                          ).then((value) {
                                            Get.back();
                                              controller.titleController.clear();
                                              controller.bodyController.clear();
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ).marginSymmetric(
                                      horizontal: 50),
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
