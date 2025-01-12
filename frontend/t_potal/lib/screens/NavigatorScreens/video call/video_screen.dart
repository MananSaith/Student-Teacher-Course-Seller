import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colorclass.dart';
import '../../../constant/font_weight.dart';
import '../../../widegts/textwidget.dart';
import 'zego_kit.dart';

class CallPageScreen extends StatelessWidget {
  CallPageScreen({super.key});
  final TextEditingController callIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        centerTitle: false,
        title: TextWidget(
          text: "call",
          fSize: 25,
          fWeight: MyFontWeight.bold,
          textColor: MyColors.white,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Call Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: MyColors.transparentBgPallet,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.call,
                  size: 80,
                  color: MyColors.primaryPallet,
                ),
              ),
              const SizedBox(height: 30),

              // TextField
              TextField(
                controller: callIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Call ID",
                  hintStyle: TextStyle(color: MyColors.secondaryPallet),
                  filled: true,
                  fillColor: MyColors.bgPallet,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: MyColors.primaryPallet,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: MyColors.secondaryPallet,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: MyColors.primaryPallet,
                      width: 2,
                    ),
                  ),
                ),
                style: TextStyle(color: MyColors.primaryPallet),
              ),
              const SizedBox(height: 20),

              // Button
              ElevatedButton(
                onPressed: () {
                  if (callIdController.text.isEmpty) {
                    // Show a message if the text field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Call ID cannot be empty!"),
                        backgroundColor: MyColors.secondaryPallet,
                      ),
                    );
                  } else {
                    // Perform action if text field is not empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Processing Call..."),
                        backgroundColor: MyColors.thirdPallet,
                      ),
                    );
                  }
                  Get.to(() => CallPage(
                        callID: callIdController.text,
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.secondaryPallet,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Start Call",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.bgPallet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
