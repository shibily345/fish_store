import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.menu),
          )
        ],
      ),
    );
  }
}
