import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colorclass.dart';
import '../constant/font_weight.dart';

// ignore: must_be_immutable
class RichTextWidget extends StatelessWidget {
  final List<TextSpan> textSpans; // List of TextSpan for rich text
  double fSize;
  FontWeight? fWeight = MyFontWeight.regular;
  Color? textColor = MyColors.black;
  final int? maxLine;
  final bool overFlow;
  final bool dir;

  RichTextWidget({
    super.key,
    required this.textSpans, // Accept List<TextSpan> for rich text
    required this.fSize,
    this.fWeight,
    this.textColor,
    this.maxLine, // Allow multiple lines by default
    this.overFlow = false, // Properly initialize optional fields
    this.dir = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: textSpans, // Using the list of TextSpans for rich text
        style: GoogleFonts.poppins(
          fontWeight: fWeight,
          fontSize: fSize,
          color: textColor,
        ),
      ),
      maxLines: maxLine, // Allow the widget to display multiple lines
      overflow: overFlow ? TextOverflow.ellipsis : TextOverflow.visible, // Handle text overflow
      textDirection: dir ? TextDirection.rtl : TextDirection.ltr,
    );
  }
}
