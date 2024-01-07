import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/auth/reset_password.dart';
import 'package:betta_store/features/store/presentation/contact_about/about_us_page.dart';
import 'package:betta_store/features/store/presentation/contact_about/tos_pp_page.dart';
import 'package:betta_store/features/store/presentation/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(
            color: Theme.of(context).indicatorColor,
            fontSize: 16,
            text: 'Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: textWidget(
                color: Theme.of(context).indicatorColor,
                fontSize: 16,
                text: 'Dark Mode'),
            trailing: Switch(
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
          ),
          ListTile(
            title: textWidget(
                color: Theme.of(context).indicatorColor,
                fontSize: 16,
                text: 'Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => const EditProfile());
            },
          ),
          ListTile(
            title: textWidget(
                color: Theme.of(context).indicatorColor,
                fontSize: 16,
                text: 'Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios),
            // Navigate to the change password page
            onTap: () {
              Get.to(() => const PasswordResetPage());
            },
          ),
          ListTile(
            title: textWidget(
                color: Theme.of(context).indicatorColor,
                fontSize: 16,
                text: 'Privacy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => const TermsAndPolicyPage());
            },
          ),
          ListTile(
            title: textWidget(
                color: Theme.of(context).indicatorColor,
                fontSize: 16,
                text: 'Terms of Service'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => const TermsAndPolicyPage());
            },
          ),
          ListTile(
            title: textWidget(
                color: Theme.of(context).indicatorColor,
                fontSize: 16,
                text: 'About Us'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => const AboutUsPage());
            },
          ),
        ].animate(interval: 100.ms).fade().fadeIn(curve: Curves.easeInOut),
      ),
    );
  }
}
