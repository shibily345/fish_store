import 'dart:io';

import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/bstore logos/fullLogoWhite.png', // Add your app logo image asset path
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contact BettaStore support',
              style: TextStyle(
                color: Theme.of(context).indicatorColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                makePhoneCall("+917510620508");
              },
              child: Row(
                children: [
                  Icon(Iconsax.call),
                  smallwidth,
                  Text(
                    '- Contact us on Phone',
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            bigSpace,
            GestureDetector(
              onTap: () {
                //makePhoneCall("8606094557");
                _launchURL(Uri.parse('mailto:bettast0re.bs@gmail.com'));
              },
              child: Row(
                children: [
                  Icon(Icons.email),
                  smallwidth,
                  Text(
                    '- Contact us on Email',
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            bigSpace,
            GestureDetector(
              onTap: () {
                //makePhoneCall("8606094557");
                _launchURL(Uri.parse('https://wa.link/9a6vz7'));
              },
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.whatsapp),
                  smallwidth,
                  Text(
                    '- Chat us on Watsapp',
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            bigSpace,
            bigSpace,
            GestureDetector(
              onTap: () {
                //makePhoneCall("8606094557");
                _launchURL(Uri.parse('https://www.instagram.com/bettast0re/'));
              },
              child: Row(
                children: [
                  Icon(Iconsax.instagram),
                  smallwidth,
                  Text(
                    '- Follow us on Instagram',
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            bigSpace,
            GestureDetector(
              onTap: () {
                //makePhoneCall("8606094557");
                _launchURL(Uri.parse('https://www.instagram.com/'));
              },
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.youtube),
                  smallwidth,
                  Text(
                    '- Subscribe us on Youtube',
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            bigSpace,
            GestureDetector(
              onTap: () {
                //makePhoneCall("8606094557");
                _launchURL(Uri.parse(
                    'https://chat.whatsapp.com/JOVUF6y2I7BHNKYu2QGImy'));
              },
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.whatsapp),
                  smallwidth,
                  Text(
                    '- Join whatsapp commuity',
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(Uri url) async {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  makePhoneCall(String phone) async {
    final url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(
      url,
      //
    )) {
      await launchUrl(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
