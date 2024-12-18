import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/colorclass.dart';
import '../../../controllers/chat controller/chat_controller.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({super.key});
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: const Text(
          'AI Chatbot',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  var message = chatController.messages[index];
                  bool isUserMessage = message['sender'] == 'user';
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? Colors.blueAccent
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['message'] ?? '',
                          style: TextStyle(
                            color: isUserMessage ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (chatController.isLoading.value)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String message = messageController.text.trim();
                      if (message.isNotEmpty) {
                        chatController.sendMessage(message);
                        messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
