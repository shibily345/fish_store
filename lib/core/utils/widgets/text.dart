import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget(
    {required String text,
    int maxline = 1,
    TextOverflow overFlow = TextOverflow.ellipsis,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black}) {
  return Text(
    maxLines: maxline,
    text,
    overflow: overFlow,
    style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: TextDecoration.none),
  );
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.texts,
  });
  final List<TextSpan> texts;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 15.0,
            color: Theme.of(context).indicatorColor,
          ),
          children: texts),
    );
  }
}
