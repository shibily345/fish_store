import 'package:betta_store/features/store/presentation/cart/shop_cart.dart';
import 'package:betta_store/features/store/presentation/breeders/breeders_page.dart';
import 'package:betta_store/features/store/presentation/home/home.dart';
import 'package:betta_store/features/store/presentation/home/shop_view.dart';
import 'package:betta_store/features/store/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomView extends StatefulWidget {
  BottomView({super.key});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  List<Widget> _buildScreens() {
    return [
      ShopingHome(),
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
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context)
          .scaffoldBackgroundColor, // Default is Theme.of(context).indicatorColor.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        //  borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.transparent,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarHeight: 70,
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
