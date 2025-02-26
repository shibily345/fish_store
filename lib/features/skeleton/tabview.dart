import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/presentation/breeders/breeders_page.dart';
import 'package:betta_store/features/Pages/presentation/cart/shop_cart.dart';
import 'package:betta_store/features/Pages/presentation/home/home.dart';
import 'package:betta_store/features/Pages/presentation/home/widgets/top_bar.dart';
import 'package:betta_store/features/Pages/presentation/profile/profile_page.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class DeskTopTab extends StatefulWidget {
  const DeskTopTab({Key? key}) : super(key: key);

  @override
  _DeskTopTabState createState() => _DeskTopTabState();
}

class _DeskTopTabState extends State<DeskTopTab> {
  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      color: Theme.of(context).primaryColor,
                      'assets/bstore logos/labelWhite.png',
                      width: 150,
                      height: 80.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ButtonsTabBar(
                          unselectedBackgroundColor: Colors.transparent,
                          unselectedLabelStyle: TextStyle(
                              color: th.indicatorColor.withOpacity(0.4)),
                          labelStyle: TextStyle(color: th.primaryColor),
                          backgroundColor:
                              Theme.of(context).splashColor.withOpacity(0.6),
                          tabs: const [
                            Tab(
                              icon: Icon(IconlyBroken.home),
                              text: ("Home"),
                            ),
                            Tab(
                              icon: Icon(IconlyBroken.bag),
                              text: ("Shop"),
                            ),
                            Tab(
                              icon: Icon(IconlyBroken.buy),
                              text: ("Cart"),
                            ),
                            Tab(
                              icon: Icon(IconlyBroken.profile),
                              text: ("Profile"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).splashColor),
                          width: 280,
                          height: 50.h,
                          child: Row(
                            children: [
                              const Center(
                                child: Icon(IconlyBroken.search),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              textWidget(
                                  text: 'Search "Fighter Fish"',
                                  color: Theme.of(context)
                                      .indicatorColor
                                      .withOpacity(0.2))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ShopingHome(),
                    BreedersPage(),
                    ShopCartPage(),
                    ProfilePage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
