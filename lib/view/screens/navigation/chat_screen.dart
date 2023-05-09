import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/navigation_controller.dart';
import '../../../../routes/routes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (controller) {
        return controller.chatClients.isEmpty
            ? const Center(
                child: Text(
                'لا يوجد مرضى',
                style: TextStyle(fontFamily: 'Expo'),
              ))
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: controller.chatClients.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Get.toNamed(
                      Routes.chatScreen,
                      arguments: controller.chatClients[index],
                    ),
                    leading: const Icon(
                      Icons.account_circle_rounded,
                      size: 45,
                    ),
                    title: Text(
                      '${controller.chatClients[index].firstName!} ${controller.chatClients[index].secondName!} ${controller.chatClients[index].firstName!}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Expo',
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      controller.chatClients[index].email!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Expo',
                        fontSize: 15,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 25,
                    ),
                  );
                },
              );
      },
    );
  }
}
