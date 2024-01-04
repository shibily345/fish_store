import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/plants/presentation/widgets/vertical.dart';
import 'package:flutter/material.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textWidget(
              text: "Aqua plants",
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        body: const Padding(
          padding: EdgeInsets.all(18.0),
          child: PlantsGrid(),
        ));
  }
}
