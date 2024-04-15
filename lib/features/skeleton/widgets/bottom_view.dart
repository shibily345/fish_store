import 'package:betta_store/features/Pages/presentation/breeders/breeders_page.dart';
import 'package:betta_store/features/Pages/presentation/cart/shop_cart.dart';
import 'package:betta_store/features/Pages/presentation/home/home.dart';
import 'package:betta_store/features/Pages/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomView extends StatefulWidget {
  const BottomView({super.key});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  List<Widget> _buildScreens() {
    return [
      const ShopingHome(),
      const BreedersPage(),
      const ShopCartPage(),
      const ProfilePage(),
    ];
  }

  late PersistentTabController _controller;
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Iconsax.home),
          title: ("Home"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Theme.of(context).indicatorColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Iconsax.shop),
          title: ("Shop"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Theme.of(context).indicatorColor,
        ),
        PersistentBottomNavBarItem(
          activeColorSecondary: Theme.of(context).primaryColor,
          icon: const Icon(Iconsax.shopping_cart),
          title: ("Cart"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Theme.of(context).indicatorColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Iconsax.personalcard),
          title: ("Profile"),
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Theme.of(context).indicatorColor,
        ),
      ];
    }

    return PersistentTabView(
      margin: EdgeInsets.only(bottom: 5.h, left: 10.w, right: 10.w),
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context)
          .splashColor
          .withOpacity(0.6), // Default is Theme.of(context).indicatorColor.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        colorBehindNavBar: Theme.of(context).splashColor,
        borderRadius: BorderRadius.circular(70.0),
      ),
      hideNavigationBar: false,

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarHeight: 65,
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
