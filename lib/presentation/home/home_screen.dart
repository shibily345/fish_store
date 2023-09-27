import 'dart:math';

import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/home/storeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
    TabController tabcontroller = TabController(length: 5, vsync: this);
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
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
                          icon: Icon(
                            Iconsax.menu_1,
                            color: Theme.of(context).primaryColor,
                          ),
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
                            isLightTheme
                                ? 'assets/bstore logos/labelBlack.png'
                                : 'assets/bstore logos/labelWhite.png',
                            width: 150.w,
                            height: 40.h,
                          ),
                        ),
                        bottom: TabBar(
                            isScrollable: true,
                            labelColor: const Color.fromARGB(255, 0, 0, 0),
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: 25.w,
                              vertical: 0,
                            ),
                            //  indicatorPadding: EdgeInsets.symmetric(horizontal: 2),
                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.circular(20.h),
                            ),
                            controller: tabcontroller,
                            tabs: [
                              Tab(
                                child: textWidget(
                                  text: "Bettas",
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Plants",
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Fishes",
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Items",
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14),
                              ),
                              Tab(
                                child: textWidget(
                                    text: "Feeds",
                                    color: Theme.of(context).primaryColor,
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
                                  height: 205.h,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: const BorderRadius.only(
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
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRouts.searchPage);
                                              },
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
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Icon(
                                                      CupertinoIcons.search,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    smallwidth,
                                                  ],
                                                ),
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
                body: StoreView(tabcontroller: tabcontroller)),
          ),
        ),
      ],
    );
  }
}
