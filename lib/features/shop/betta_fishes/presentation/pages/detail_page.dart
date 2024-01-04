import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/widgets/vertical_grid.dart';
import 'package:flutter/material.dart';

class BettaFishPage extends StatelessWidget {
  const BettaFishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textWidget(
              text: "Betta Fishes",
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        body: const Padding(
          padding: EdgeInsets.all(18.0),
          child: BettaFishGrid(),
        ));
  }
}
