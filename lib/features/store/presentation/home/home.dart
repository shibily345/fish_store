import 'package:betta_store/features/shop/betta_fishes/presentation/widgets/horizontal_grid.dart';
import 'package:betta_store/features/shop/fishes/presentation/widgets/horizontal_grid.dart';
import 'package:betta_store/features/store/presentation/home/widgets/slider.dart';
import 'package:betta_store/features/store/presentation/home/widgets/top_bar.dart';
import 'package:betta_store/features/store/presentation/home/widgets/welcome_comment.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ShopingHome extends StatelessWidget {
  const ShopingHome({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              WelcomeComment(),
              AdSliders(),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: BettaFishHorizontalGrid(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: FishesHorizontslGrid(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: BettaFishHorizontalGrid(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: BettaFishHorizontalGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
