import 'package:betta_store/core/utils/res/responsive.dart';
import 'package:betta_store/features/Pages/presentation/home/desktop_home.dart';
import 'package:betta_store/features/Pages/presentation/home/mobile_home.dart';
import 'package:flutter/material.dart';

class ShopingHome extends StatelessWidget {
  const ShopingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: MobileShopingHome(),
      tablet: DeskTopShopingHome(),
      desktop: DeskTopShopingHome(),
    );
  }
}
