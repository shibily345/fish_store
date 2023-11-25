import 'package:betta_store/core/utils/widgets/drawer.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/home/search_page.dart';
import 'package:betta_store/features/store/presentation/home/storeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final PersistentTabController _controller = PersistentTabController();
  final ScrollController _scrollController = ScrollController();
  // @override
  // void initState() {
  //   Get.find<UserInfoController>().getUserInfo();
  //   super.initState();
  // }

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
    Get.find<UserInfoController>().getUserInfo();
    TabController tabcontroller = TabController(length: 6, vsync: this);
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: const Drawer(
            child: DrawerItems(),
          ),
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
                          onPressed: () {
                            _openDrawer();
                          },
                          icon: Icon(
                            IconlyBroken.more_circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        expandedHeight: 240.h,
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
                            color: Theme.of(context).primaryColor,
                            'assets/bstore logos/labelWhite.png',
                            width: 120.w,
                            height: 40.h,
                          ),
                        ),
                        bottom: TabBar(
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.2),
                            unselectedLabelStyle: TextStyle(),
                            isScrollable: true,
                            //labelColor: const Color.fromARGB(255, 0, 0, 0),
                            // labelPadding: EdgeInsets.symmetric(
                            //   horizontal: 25.w,
                            //   vertical: 0,
                            // ),
                            // //  indicatorPadding: EdgeInsets.symmetric(horizontal: 2),
                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            // indicatorSize: TabBarIndicatorSize.tab,

                            controller: tabcontroller,
                            tabs: [
                              Tab(
                                text: "Betta Fishes",
                              ),
                              Tab(
                                text: "Other Fishes",
                              ),
                              Tab(
                                text: "Plants",
                              ),
                              Tab(
                                text: "Items",
                              ),
                              Tab(
                                text: "Feeds",
                              ),
                              Tab(
                                text: "All",
                              ),
                            ]),
                        flexibleSpace: LayoutBuilder(builder: (
                          BuildContext context,
                          BoxConstraints constraints,
                        ) {
                          return FlexibleSpaceBar(
                            background: Padding(
                              padding: EdgeInsets.all(8.0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  bigSpace,
                                  smallSpace,
                                  bigSpace,
                                  smallSpace,
                                  GetBuilder<UserInfoController>(
                                      builder: (user) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 8.0.h,
                                        left: 10.w,
                                      ),
                                      child: textWidget(
                                        color: Theme.of(context).indicatorColor,
                                        text: user.isLoading
                                            ? "Hi " +
                                                user.userModel.name! +
                                                " !"
                                            : "Hi There...!",
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 70.0.h,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => SerachPage());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Theme.of(context).splashColor),
                                        width: Get.width,
                                        height: 50.h,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              textWidget(
                                                  text:
                                                      'Search  "Full red ohm"',
                                                  color: Theme.of(context)
                                                      .indicatorColor
                                                      .withOpacity(0.2)),
                                              Icon(Iconsax.search_favorite_1)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
