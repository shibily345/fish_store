import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/presentation/ads/google_ads.dart';
import 'package:betta_store/features/products/presentation/other_fishes/widgets/vertical_grid.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class OtherFishPage extends StatelessWidget {
  const OtherFishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textWidget(
              text: "Other Fishes",
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        bottomNavigationBar: kIsWeb
            ? const SizedBox()
            : BannerAdWId(
                unitIdAndroid: "ca-app-pub-1634533782017400/3914305606"),
        body: const Padding(
          padding: EdgeInsets.all(18.0),
          child: OtherFishesGrid(),
        ));
  }
}
