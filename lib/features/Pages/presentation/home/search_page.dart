import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/features/Pages/presentation/ads/google_ads.dart';
import 'package:betta_store/features/products/presentation/controller/product_info_controller.dart';

import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({super.key});

  @override
  State<SerachPage> createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  var fishes = Get.find<ProductInfoController>();

  List<dynamic> allProducts = [];
  final FocusNode serchFocus = FocusNode();
  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    allProducts.addAll(fishes.productInfoList);

    super.initState();
    _runFilter('');
  }

  List<dynamic> _foundResults = [];

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];

    if (enteredKeyword.isEmpty) {
      results = allProducts;
    } else {
      results = allProducts
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kIsWeb
          ? const SizedBox()
          : BannerAdWId(
              unitIdAndroid: "ca-app-pub-1634533782017400/3914305606"),
      body: NestedScrollView(
          clipBehavior: Clip.antiAlias,
          physics: const BouncingScrollPhysics(),
          // controller: _scrollController,
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxScrolled,
          ) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 145.h,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                pinned: true,
                toolbarHeight: 65.h,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                // floating: true,
                automaticallyImplyLeading: false,
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    color: Theme.of(context).primaryColor,
                    'assets/bstore logos/labelWhite.png',
                    width: 150.w,
                    height: 40.h,
                  ),
                ),
                flexibleSpace: LayoutBuilder(builder: (
                  BuildContext context,
                  BoxConstraints constraints,
                ) {
                  return FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.all(18.0.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 50.0.h,

                            //  padding: EdgeInsets.all(2.0.h),
                            // margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).splashColor),
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                autofocus: true,
                                focusNode: serchFocus,
                                onChanged: (value) => _runFilter(value),
                                style: TextStyle(
                                    color: Theme.of(context).indicatorColor),
                                // controller: nameController,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.2)),
                                    hintText: 'Search "red betta fish" ',
                                    prefixIcon: Icon(
                                      CupertinoIcons.search,
                                      color: Theme.of(context).splashColor,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: _foundResults.isNotEmpty
                ? ProductTileGrid(productInfoList: _foundResults)
                : const SerchTile(),
          )),
    );
  }
}

class SerchTile extends StatelessWidget {
  const SerchTile({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Center(
          child: Column(
            children: [
              textWidget(
                  text: 'Search product not availeble',
                  color: Theme.of(context).indicatorColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w300),
              kIsWeb
                  ? const SizedBox()
                  : BannerAdWId(
                      unitIdAndroid: "ca-app-pub-1634533782017400/3914305606"),
            ],
          ),
        ));
  }
}
