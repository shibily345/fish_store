import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';

import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({super.key});

  @override
  State<SerachPage> createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];
  final FocusNode serchFocus = FocusNode();
  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
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
                    background: Stack(
                      children: [
                        Positioned(
                          top: 90.h,
                          right: 10.w,
                          left: 10.w,
                          child: Padding(
                            padding: EdgeInsets.all(18.0.h),
                            child: Container(
                              height: 45.0,

                              padding: EdgeInsets.all(2.0.h),
                              // margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
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
                                      hintText: ' search "Full red ohm"',
                                      prefixIcon: Icon(
                                        CupertinoIcons.search,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: _foundResults.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _foundResults.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2.5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouts.getProductDetailPage(
                              _foundResults[index].id!));
                        },
                        child: Container(
                          width: 190.w,
                          height: 250.h,
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CachedNetworkImage(
                                height: 115.h,
                                width: 160.w,
                                imageUrl: AppConstents.BASE_URL +
                                    AppConstents.UPLOAD_URL +
                                    _foundResults[index].img!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const Center(
                                    child: CustomeLoader(
                                  bg: Colors.transparent,
                                )),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                margin: const EdgeInsets.all(10),
                                width: 175.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120.w,
                                      child: textWidget(
                                          text: _foundResults[index].name!,
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    textWidget(
                                        text:
                                            '₹ ${_foundResults[index].price!} /-',
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    textWidget(
                                        text:
                                            '@${_foundResults[index].breeder!}',
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300),
                                  ]
                                      .animate(interval: 200.ms)
                                      .fade()
                                      .fadeIn(curve: Curves.easeInOutExpo),
                                ),
                              ),
                            ]
                                .animate(interval: 100.ms)
                                .fade()
                                .fadeIn(curve: Curves.easeInOutExpo),
                          ),
                        ),
                      );
                    })
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
          child: textWidget(
              text: 'Search product not availeble',
              color: Theme.of(context).indicatorColor,
              fontSize: 10,
              fontWeight: FontWeight.w300),
        ));
  }
}
