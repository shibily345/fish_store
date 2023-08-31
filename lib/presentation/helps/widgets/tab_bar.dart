import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/theme/constants.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required TabController tabcontroller,
  }) : _tabcontroller = tabcontroller;

  final TabController _tabcontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 25),
              //  indicatorPadding: EdgeInsets.symmetric(horizontal: 2),
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white)),
              controller: _tabcontroller,
              tabs: [
                Tab(
                  child: textWidget(text: "All", color: Colors.white),
                ),
                Tab(
                  child: textWidget(text: "Half Moon", color: Colors.white),
                ),
                Tab(
                  child: textWidget(text: "Plakarts", color: Colors.white),
                ),
                Tab(
                  child: textWidget(text: "CrownTail", color: Colors.white),
                ),
              ]),
        ],
      ),
    );
  }
}

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({
    super.key,
    required TabController tabcontroller,
    required this.fishes,
  }) : _tabcontroller = tabcontroller;

  final TabController _tabcontroller;
  final List<String> fishes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: Get.width,
      child: TabBarView(controller: _tabcontroller, children: [
        GridView.builder(
          itemCount: fishes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: Container(
                    padding: EdgeInsets.only(top: 40, left: 20),
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(
                      color: secondaryColor20DarkTheme,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.elliptical(180, 160),
                          topLeft: Radius.elliptical(180, 160)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                            text: "Yellow Rosstail",
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                        textWidget(
                            text: "@Devine_Bettas",
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.w300),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 90,
                    child: Image.asset(
                      fishes[index],
                      width: 150,
                      height: 150,
                    )),
                Positioned(
                  right: 20,
                  child: IconButton.filled(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.heart,
                      color: Colors.white,
                    ),
                    highlightColor: Colors.red,
                  ),
                ),
                Positioned(
                  bottom: 45,
                  right: 35,
                  child: FloatingActionButton.small(
                    child: Icon(Iconsax.bag_2),
                    onPressed: () {},
                  ),
                )
              ],
            );
          },
        ),
        Container(),
        Container(),
        Container(),
      ]),
    );
  }
}
