import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../constant/string_constant.dart';


class CallPage extends StatelessWidget {
  const CallPage({super.key, required this.callID});
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: MyText
          .zegoChatId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: MyText
          .zegoAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: '123123',
      userName: 'sufyanbhai',
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
