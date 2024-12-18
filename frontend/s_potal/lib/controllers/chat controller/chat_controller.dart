import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:s_potal/constant/string_constant.dart';

class ChatController extends GetxController {
  var messages = <Map<String, String>>[].obs; // To store chat messages
  var isLoading = false.obs;

  // Function to send message to the API and receive a response
  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    // Add the user message to the chat list
    messages.add({'sender': 'user', 'message': message});

    // Set loading to true to indicate the AI is processing
    isLoading.value = true;

    try {
      // Send the message to the AI API
      final response = await http.post(
        Uri.parse(MyText.basicUrliChat),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      // Handle response from the AI API
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String aiMessage = data[
            'response']; // Assuming the API returns a field called 'response'
        messages.add({'sender': 'ai', 'message': aiMessage});
      } else {
        messages.add(
            {'sender': 'ai', 'message': 'Error: Unable to fetch AI response.'});
      }
    } catch (e) {
      messages.add(
          {'sender': 'ai', 'message': 'Error: Unable to reach the server.'});
    } finally {
      isLoading.value = false; // Set loading to false after the API call
    }
  }
}
