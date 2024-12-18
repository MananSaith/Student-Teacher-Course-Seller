import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/string_constant.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3), // Semi-transparent background
      child: Center(
        child: Lottie.asset(MyText.loaderLottie), // Loading spinner
      ),
    );
  }
}
