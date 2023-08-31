import 'dart:ui';

import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/home/Shop/shop_cart.dart';
import 'package:betta_store/presentation/home/breeders/breeders_page.dart';
import 'package:betta_store/presentation/home/home_screen.dart';
import 'package:betta_store/presentation/home/profile/profile_page.dart';
import 'package:betta_store/utils/theme/constants.dart';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PersistentTabController _controller;
  int _currentIndex = 0;
  List pages = [
    HomeScreen(),
    BreedersPage(),
    ShopCartPage(),
    ProfilePage(),
  ];
  void onTapNav(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    // TODO: implement initState
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      BreedersPage(),
      ShopCartPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Iconsax.home),
        title: ("Home"),
        activeColorPrimary: secondaryColor20DarkTheme,
        inactiveColorPrimary: secondaryColor80DarkTheme,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Iconsax.shop),
        title: ("Shop"),
        activeColorPrimary: secondaryColor20DarkTheme,
        inactiveColorPrimary: secondaryColor80DarkTheme,
      ),
      PersistentBottomNavBarItem(
        activeColorSecondary: secondaryColor20DarkTheme,
        icon: Icon(Iconsax.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: secondaryColor20DarkTheme,
        inactiveColorPrimary: secondaryColor80DarkTheme,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Iconsax.personalcard),
        title: ("Profile"),
        activeColorPrimary: secondaryColor20DarkTheme,
        inactiveColorPrimary: secondaryColor80DarkTheme,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: secondaryColor60DarkTheme, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarHeight: 70,
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(body: pages[_currentIndex]),
        Positioned(
            bottom: 20,
            left: 15,
            child: BlurContainer(
                child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: BottomNavigationBar(
                      currentIndex: _currentIndex,
                      backgroundColor: Colors.transparent,
                      onTap: onTapNav,
                      elevation: 0,
                      items: [
                        BottomNavigationBarItem(
                            backgroundColor: Colors.transparent,
                            icon: Icon(Iconsax.home),
                            label: "home"),
                        BottomNavigationBarItem(
                            icon: Icon(Iconsax.shop), label: "Breeders"),
                        BottomNavigationBarItem(
                            icon: Icon(Iconsax.shopping_bag), label: "Cart"),
                        BottomNavigationBarItem(
                            icon: Icon(Iconsax.personalcard), label: "profile")
                      ],
                    )),
                width: 380,
                height: 70))
      ],
    );
  }
*/
}
