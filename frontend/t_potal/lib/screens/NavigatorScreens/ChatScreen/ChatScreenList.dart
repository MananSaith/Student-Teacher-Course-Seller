import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart'; // Import ZEGOCLOUD package

import '../../../controllers/techerDataFromNode/teacherInfo/teacher_crud.dart';
import 'zegopopmenubutton.dart'; // For ZEGOCLOUD ZIM

class ZIMKitDemoHomePage extends StatefulWidget {
  const ZIMKitDemoHomePage({Key? key}) : super(key: key);

  @override
  _ZIMKitDemoHomePageState createState() => _ZIMKitDemoHomePageState();
}

class _ZIMKitDemoHomePageState extends State<ZIMKitDemoHomePage> {
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getdata();
    // Initialize ZEGOCLOUD connection and login
  }

  void getdata() async {
    await teacherCrudController.getUserById(uid: currentUser!.uid).then((e) {
      _connectToZIM();
    });
    setState(() {});
  }

  // Connect to ZIMKit with static username and ID
  Future<void> _connectToZIM() async {
    // await teacherController.getUserById(uid: currentUser!.uid);
    // final teacher = teacherController.selectedTeacher.value;
    try {
      await ZIMKit().connectUser(
          id: teacherCrudController.selectedTeacher.value!.mcid,
          name: teacherCrudController.selectedTeacher.value!.name);
      print("Connected to ZEGOCLOUD ZIMKit");
      setState(() {});
    } catch (e) {
      print("Error connecting to ZEGOCLOUD ZIMKit: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        actions: [Zegopopmenubutton()],
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
