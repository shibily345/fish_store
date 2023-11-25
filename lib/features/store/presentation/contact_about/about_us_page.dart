import 'dart:io';

import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                'Welcome to BettaStore',
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'BettaStore is the ultimate destination for aqua lovers, fish breeders, and enthusiasts. Our app version 1.0.0 is specially crafted for aqua lovers and aqua fish stores, providing a platform to buy and sell high-quality aquatic fishes. Dive into the fascinating world of aquatic life with our extensive collection of Betta fishes - the Siamese fighting fish that holds a significant economic value in our area.',
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                'Key Features:',
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '- Buy and sell high-quality Betta fishes',
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 16,
                ),
              ),
              Text(
                '- Explore a wide variety of aquatic fishes',
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 16,
                ),
              ),
              Text(
                '- Connect with fellow aqua lovers and breeders',
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Join us in creating a vibrant community of aqua enthusiasts. Let BettaStore be your gateway to a world filled with stunning aquatic creatures.',
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              bigSpace,
              GestureDetector(
                onTap: () {
                  //makePhoneCall("8606094557");
                  _launchURL(
                      Uri.parse('https://www.instagram.com/shibily_sf/'));
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
      ),
    );
  }

  _launchURL(Uri url) async {
    if (await canLaunchUrl(
      url,
    )) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  makePhoneCall(String phone) async {
    final url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(
      url,
      // mode: LaunchMode.externalApplication,
    )) {
      await launchUrl(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
