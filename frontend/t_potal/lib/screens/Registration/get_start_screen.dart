import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/colorclass.dart';
import '../../constant/font_weight.dart';
import '../../constant/string_constant.dart';
import '../../widegts/custum_button.dart';
import '../../widegts/rich_text_widget.dart';
import '../../widegts/textwidget.dart';
import 'login_screen.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Preload the image so it shows up faster
  //precacheImage(AssetImage(MyText.teacherBackgrounPik), context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration:  BoxDecoration(
               image: DecorationImage(
                image: AssetImage(MyText.teacherBackgrounPik),
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          
           Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.07,),
                  TextWidget(text: MyText.appName, fSize: 35,textColor: MyColors.camel,fWeight: MyFontWeight.extra,),
                  const Spacer(flex: 2,),
                  Expanded(
                    child: RichTextWidget(
                      fWeight: MyFontWeight.bold,
                      fSize: 20,
                      textSpans: [
                             TextSpan(
                              text: MyText.punchLine1, 
                              style:TextStyle(color: MyColors.camel)
                              ),
                              TextSpan(
                              text: MyText.punchLine2, 
                              style:  TextStyle(color: MyColors.primaryPallet)
                              ),
                      ],)
                  
                  ),
                  Center(
                    child: CustomElevatedButton(
                      text:  "Let's Get Start",
                      backgroundColor: MyColors.primaryPallet,
                      endIcon: Icons.arrow_right_alt,
                      onPressed: ()=> Get.offAll(()=>const LoginScreen()),
                    ),
                  )
                ],
            ),
            )
        ],
      ),
    );
  }
}
