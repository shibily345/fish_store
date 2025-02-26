// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// This example demonstrates native templates.
class NativeTemplateExample extends StatefulWidget {
  const NativeTemplateExample({super.key});

  @override
  _NativeTemplateExampleExampleState createState() =>
      _NativeTemplateExampleExampleState();
}

class _NativeTemplateExampleExampleState extends State<NativeTemplateExample> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  Widget build(BuildContext context) => Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300,
                minHeight: 350,
                maxHeight: 400,
                maxWidth: 450,
              ),
              child: AdWidget(ad: _nativeAd!),
            )),
      ));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _nativeAd = NativeAd(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/2247696110'
            : 'ca-app-pub-3940256099942544/3986624511',
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            //  mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            // callToActionTextStyle: NativeTemplateTextStyle(
            //     textColor: Colors.cyan,
            //     backgroundColor: Colors.red,
            //     style: NativeTemplateFontStyle.monospace,
            //     size: 16.0),
            // primaryTextStyle: NativeTemplateTextStyle(
            //     textColor: Colors.red,
            //     backgroundColor: Colors.cyan,
            //     style: NativeTemplateFontStyle.italic,
            //     size: 16.0),
            // secondaryTextStyle: NativeTemplateTextStyle(
            //     textColor: Colors.green,
            //     backgroundColor: Colors.black,
            //     style: NativeTemplateFontStyle.bold,
            //     size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.amber,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
  }
}
