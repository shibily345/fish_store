// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class BannerAdWId extends StatefulWidget {
  String? unitIdAndroid;
  String? unitIdIos;

  BannerAdWId({
    Key? key,
    this.unitIdAndroid,
    this.unitIdIos,
  }) : super(key: key);
  @override
  _BannerAdWIdState createState() => _BannerAdWIdState();
}

class _BannerAdWIdState extends State<BannerAdWId> {
  BannerAd? _bannerAd;
  bool _bannerAdIsLoaded = false;

  @override
  Widget build(BuildContext context) {
    final BannerAd? bannerAd = _bannerAd;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _bannerAdIsLoaded && bannerAd != null && !kIsWeb
            ? Container(
                height: bannerAd.size.height.toDouble(),
                width: bannerAd.size.width.toDouble(),
                child: AdWidget(ad: bannerAd))
            : SizedBox());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? widget.unitIdAndroid ?? 'ca-app-pub-1634533782017400/7939507990'
            : widget.unitIdIos ?? 'ca-app-pub-1634533782017400/5219648413',
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('$BannerAd loaded.');
            setState(() {
              _bannerAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print(
                '$BannerAd failedToLoad: $error ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        ),
        request: AdRequest())
      ..load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }
}
