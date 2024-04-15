import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/presentation/contact_about/tos_pp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivecyLabelWidget extends StatelessWidget {
  const PrivecyLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(const TermsAndPolicyPage());
      },
      child: RichTextWidget(texts: [
        TextSpan(
          style: TextStyle(
              fontSize: 10, color: Theme.of(context).primaryColorDark),
          text: 'Applay our ',
        ),
        TextSpan(
          text: ' Terms of Service \n',
          style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark),
        ),
        TextSpan(
          text: '      and ',
          style: TextStyle(
              fontSize: 10, color: Theme.of(context).primaryColorDark),
        ),
        TextSpan(
            text: 'Privacy Policy',
            style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark)),
      ]),
    );
  }
}
