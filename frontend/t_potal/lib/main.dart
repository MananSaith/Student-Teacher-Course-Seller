import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'constant/colorclass.dart';
import 'constant/string_constant.dart';
import 'controllers/Utils_Controller/wrapper.dart';
import 'firebase_options.dart';

void main() async {

   ZIMKit().init(
    appID: MyText.zegoChatId, // your appid
    appSign: MyText.zegoAppSign, // your appSign
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: MyText.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryPallet),
        useMaterial3: true,
      ),
      home: const Wrapper(),
    );
  }
}
