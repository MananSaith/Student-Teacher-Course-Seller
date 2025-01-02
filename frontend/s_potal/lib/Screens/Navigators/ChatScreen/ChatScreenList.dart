// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart'; // Import ZEGOCLOUD package

import '../../../controllers/NodeStdCrud/studendController.dart';
import 'zegopopmenubutton.dart'; // For ZEGOCLOUD ZIM

class ZIMKitDemoHomePage extends StatefulWidget {
  const ZIMKitDemoHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ZIMKitDemoHomePageState createState() => _ZIMKitDemoHomePageState();
}

class _ZIMKitDemoHomePageState extends State<ZIMKitDemoHomePage> {
  final StudentController studentCrudController = Get.put(StudentController());
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getdata();
    // Initialize ZEGOCLOUD connection and login
  }

  void getdata() async {
    await studentCrudController.fetchStudentByUid(currentUser!.uid).then((e) {
      _connectToZIM();
    });
    setState(() {});
  }

  // Connect to ZIMKit with static username and ID
  Future<void> _connectToZIM() async {
    await ZIMKit().connectUser(
        id: studentCrudController.currentStudent.value!.mcid,
        name: studentCrudController.currentStudent.value!.name);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        actions: const [Zegopopmenubutton()],
      ),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ZIMKitMessageListPage(
                conversationID: conversation.id,
                conversationType: conversation.type,
              );
            },
          ));
        },
      ),
    );
  }
}
