import 'dart:math';

import 'package:betta_store/presentation/helps/widgets/bottom_nav_bar.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/tab_bar.dart';
import 'package:betta_store/presentation/home/storeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/theme/constants.dart';
import '../helps/widgets/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final PersistentTabController _controller = PersistentTabController();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    _selectedIndex.value = index;
    _controller.jumpToTab(
      index,
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 5, vsync: this);

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: NestedScrollView(
                clipBehavior: Clip.antiAlias,
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                headerSliverBuilder: (
                  BuildContext context,
                  bool innerBoxScrolled,
                ) {
                  return <Widget>[
                    SliverAppBar(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Iconsax.menu_1),
                        ),
                        expandedHeight: 225.h,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0,
                        pinned: true,
                        toolbarHeight: 65.h,
                        // floating: true,
                        automaticallyImplyLeading: false,
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/bstore logos/labelWhite.png',
                            width: 150.w,
                            height: 50.h,
                          ),
                        ),
                        bottom: TabBar(
                            isScrollable: true,
                            labelColor: const Color.fromARGB(255, 0, 0, 0),
                            labelPadding:
                                EdgeInsets.symmetric(horizontal: 25.w),
                            //  indicatorPadding: EdgeInsets.symmetric(horizontal: 2),
                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.h),
                                border: Border.all(color: primaryColor)),
                            controller: _tabcontroller,
                            tabs: [
                              Tab(
                                child: textWidget(
                                  text: "Bettas",
                                  color: primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Plants",
                                    color: primaryColor,
                                    fontSize: 14),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Fishes",
                                    color: primaryColor,
                                    fontSize: 14),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Items",
                                    color: primaryColor,
                                    fontSize: 14),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Feeds",
                                    color: primaryColor,
                                    fontSize: 14),
                              ),
                            ]),
                        flexibleSpace: LayoutBuilder(builder: (
                          BuildContext context,
                          BoxConstraints constraints,
                        ) {
                          return FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                Container(
                                  height: 220,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                    // gradient: LinearGradient(
                                    //   colors: [
                                    //     const Color.fromARGB(255, 243, 222, 33),
                                    //     Color.fromARGB(255, 184, 154, 0)
                                    //   ], // List of colors in the gradient
                                    //   begin: Alignment
                                    //       .topLeft, // Starting point of the gradient
                                    //   end: Alignment
                                    //       .bottomRight, // Ending point of the gradient
                                    //   stops: [
                                    //     0.0,
                                    //     1.0
                                    //   ], // Stops for each color in the gradient
                                    //   // You can also use `TileMode` to control how the gradient is repeated
                                    //   tileMode: TileMode
                                    //       .clamp, // This will repeat the gradient to fill the container
                                    // ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 120.h,
                                  right: 10.w,
                                  left: 10.w,
                                  child: Padding(
                                    padding: EdgeInsets.all(18.0.h),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: AnimatedBuilder(
                                        animation: _scrollController,
                                        builder: (context, child) {
                                          return GestureDetector(
                                            child: AnimatedContainer(
                                              width: (!_scrollController
                                                          .hasClients ||
                                                      _scrollController
                                                              .positions
                                                              .length >
                                                          1)
                                                  ? Get.width.w
                                                  : max(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          _scrollController
                                                              .offset
                                                              .roundToDouble(),
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          (rotated ? 0 : 75),
                                                    ),
                                              height: 45.0,
                                              duration: const Duration(
                                                milliseconds: 150,
                                              ),
                                              padding: EdgeInsets.all(2.0.h),
                                              // margin: EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20.0,
                                                ),
                                                // gradient: LinearGradient(
                                                //   colors: [
                                                //     const Color.fromARGB(
                                                //         255, 253, 253, 253),
                                                //     const Color.fromARGB(
                                                //         255, 183, 183, 183)
                                                //   ], // List of colors in the gradient
                                                //   begin: Alignment
                                                //       .topLeft, // Starting point of the gradient
                                                //   end: Alignment
                                                //       .bottomRight, // Ending point of the gradient
                                                //   stops: [
                                                //     0.0,
                                                //     1.0
                                                //   ], // Stops for each color in the gradient
                                                //   // You can also use `TileMode` to control how the gradient is repeated
                                                //   tileMode: TileMode
                                                //       .clamp, // This will repeat the gradient to fill the container
                                                // ),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 5.0,
                                                    offset: Offset(1.5, 1.5),
                                                    // shadow direction: bottom right
                                                  )
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.search,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                                  smallwidth,
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                  ];
                },
                body: StoreView(tabcontroller: _tabcontroller)),
          ),
        ),
      ],
    );
  }
}
