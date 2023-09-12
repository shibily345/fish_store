import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

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
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
        fontSize: ScreenUtil().setSp(fontSize),
        fontWeight: fontWeight,
        color: color,
        decoration: TextDecoration.none),
  );
}

class autsctext extends StatelessWidget {
  final String text;
  final double width;
  const autsctext({super.key, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: width,
      child: Marquee(
        text: text,
        style: const TextStyle(fontSize: 16.0),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        blankSpace: 20.0,
        velocity: 70.0,
        pauseAfterRound: const Duration(seconds: 2),
        startPadding: 10.0,
        accelerationDuration: const Duration(seconds: 2),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  RichTextWidget({
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
