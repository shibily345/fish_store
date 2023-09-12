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

class HomeScreenTest extends StatefulWidget {
  const HomeScreenTest({super.key});

  @override
  State<HomeScreenTest> createState() => _HomeScreenTestState();
}

class _HomeScreenTestState extends State<HomeScreenTest>
    with TickerProviderStateMixin {
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
          body: NestedScrollView(
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
                      backgroundColor: Theme.of(context).primaryColor,
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
                          labelPadding: EdgeInsets.symmetric(horizontal: 25.w),
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
                            background: ListView(
                          children: [
                            bigSpace,
                            bigSpace,
                            textWidget(
                                text: "Let's Explore \n Find new aquamate",
                                maxline: 2,
                                color: Theme.of(context).secondaryHeaderColor)
                          ],
                        ));
                      })),
                ];
              },
              body: StoreView(tabcontroller: _tabcontroller)),
        ),
      ],
    );
  }
}
