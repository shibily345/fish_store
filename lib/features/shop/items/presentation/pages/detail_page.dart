import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/widgets/vertical_grid.dart';
import 'package:betta_store/features/shop/items/presentation/widgets/vertical.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textWidget(
              text: "Aquarium products",
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ItemsGrid(),
        ));
  }
}
