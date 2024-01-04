import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/feeds/presentation/widgets/vertical_grid.dart';
import 'package:flutter/material.dart';

class FeedsFishPage extends StatelessWidget {
  const FeedsFishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textWidget(
              text: "Feeds for Fishes",
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        body: const Padding(
          padding: EdgeInsets.all(18.0),
          child: FeedsGrid(),
        ));
  }
}
