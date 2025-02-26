import "package:betta_store/features/Pages/presentation/breeders/breeders_page.dart";
import "package:betta_store/features/Pages/presentation/cart/shop_cart.dart";
import "package:betta_store/features/Pages/presentation/home/home.dart";
import "package:betta_store/features/Pages/presentation/profile/profile_page.dart";
import "package:betta_store/features/skeleton/widgets/settings.dart";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

class BottomView extends StatefulWidget {
  const BottomView({super.key});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  final PersistentTabController _controller = PersistentTabController();
  Settings settings = Settings();

  List<PersistentTabConfig> _tabs(ThemeData th) => [
        PersistentTabConfig(
          screen: const ShopingHome(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Home",
            activeForegroundColor: th.primaryColor,
            inactiveForegroundColor: Colors.grey,
          ),
        ),
        PersistentTabConfig(
          screen: const BreedersPage(),
          item: ItemConfig(
            icon: const Icon(Icons.shop),
            title: "Shops",
            activeForegroundColor: th.primaryColor,
            inactiveForegroundColor: Colors.grey,
          ),
        ),
        // PersistentTabConfig.noScreen(
        //   item: ItemConfig(
        //     icon: const Icon(Icons.add),
        //     title: "Add",
        //     activeForegroundColor: Colors.blueAccent,
        //     inactiveForegroundColor: Colors.grey,
        //   ),
        //   onPressed: (context) {
        //     pushWithNavBar(
        //       context,
        //       DialogRoute(
        //         context: context,
        //         builder: (context) => const ExampleDialog(),
        //       ),
        //     );
        //   },
        // ),
        PersistentTabConfig(
          screen: const ShopCartPage(),
          item: ItemConfig(
            icon: const Icon(Icons.shopping_bag),
            title: "Cart",
            activeForegroundColor: th.primaryColor,
            inactiveForegroundColor: Colors.grey,
          ),
        ),
        PersistentTabConfig(
          screen: const ProfilePage(),
          item: ItemConfig(
            icon: const Icon(Icons.settings),
            title: "Profile",
            activeForegroundColor: th.primaryColor,
            inactiveForegroundColor: Colors.grey,
          ),
        ),
      ];

  // @override
  // Widget build(BuildContext context) {
  //   ThemeData th = Theme.of(context);
  //   return PersistentTabView(
  //     controller: _controller,
  //     tabs: _tabs(th),
  //     navBarBuilder: (navBarConfig) => settings.navBarBuilder(
  //       navBarConfig,
  //       NavBarDecoration(
  //         padding: EdgeInsets.all(4),
  //         color: th.splashColor.withOpacity(0.5),
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       const ItemAnimation(),
  //       const NeumorphicProperties(),
  //     ),
  //     backgroundColor: Colors.transparent,
  //     margin: EdgeInsets.all(4),
  //     // avoidBottomPadding: settings.avoidBottomPadding,
  //     // handleAndroidBackButtonPress: settings.handleAndroidBackButtonPress,
  //     // resizeToAvoidBottomInset: settings.resizeToAvoidBottomInset,
  //     // stateManagement: settings.stateManagement,
  //     onWillPop: (context) async {
  //       await showDialog(
  //         context: context,
  //         builder: (context) => Dialog(
  //           child: Center(
  //             child: ElevatedButton(
  //               child: const Text("Close"),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ),
  //         ),
  //       );
  //       return false;
  //     },
  //     //  hideNavigationBar: settings.hideNavBar,
  //     popAllScreensOnTapOfSelectedTab: settings.popAllScreensOnTapOfSelectedTab,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return PersistentTabView(
      controller: _controller,
      tabs: _tabs(th),
      navBarBuilder: (navBarConfig) => settings.navBarBuilder(
        navBarConfig,
        NavBarDecoration(
          padding: const EdgeInsets.all(4),
          color: th.splashColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        const ItemAnimation(),
        const NeumorphicProperties(),
      ),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.all(4),
      // avoidBottomPadding: settings.avoidBottomPadding,
      // handleAndroidBackButtonPress: settings.handleAndroidBackButtonPress,
      // resizeToAvoidBottomInset: settings.resizeToAvoidBottomInset,
      // stateManagement: settings.stateManagement,
      onWillPop: (context) async {
        await showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Center(
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
        return false;
      },
      //  hideNavigationBar: settings.hideNavBar,
      popAllScreensOnTapOfSelectedTab: settings.popAllScreensOnTapOfSelectedTab,
    );
  }
}
