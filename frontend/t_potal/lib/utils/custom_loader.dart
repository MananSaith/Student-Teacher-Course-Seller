import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/string_constant.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      color: const Color.fromARGB(255, 0, 0, 0)
          .withOpacity(0.3), // Semi-transparent background
      child: Center(
        child: Lottie.asset(MyText.loaderLottie), // Loading spinner
      ),
    );
  }
}
