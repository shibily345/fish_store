import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/feeds_info_controller.dart';
import 'package:betta_store/infrastructure/controller/items_info_controller.dart';
import 'package:betta_store/infrastructure/controller/other_fish_info_controller.dart';
import 'package:betta_store/infrastructure/controller/plants_info_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:remove_background/crop_widget.dart';

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

  @override
  void initState() {
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
    super.initState();
  }

  bool _startSerch = false;

  List<dynamic> _foundResults = [];

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allProducts;
    } else {
      results = allProducts
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _startSerch = true;
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
                          child: Align(
                              alignment: Alignment.centerRight,
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
                                child: TextFormField(
                                  onChanged: (value) => _runFilter(value),
                                  style: TextStyle(
                                      color: Theme.of(context).indicatorColor),
                                  // controller: nameController,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      hintText: allProducts.length.toString(),
                                      prefixIcon: Icon(
                                        CupertinoIcons.search,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      border: InputBorder.none),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ];
        },
        body: _startSerch == true
            ? ListView.builder(
                itemCount: _foundResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (_foundResults[index].typeId == 4) {
                        Get.toNamed(
                            AppRouts.getfishDetails(_foundResults[index].id));
                      } else if (_foundResults[index].typeId == 5) {
                        Get.toNamed(
                            AppRouts.getPlantDetails(_foundResults[index].id));
                      } else if (_foundResults[index].typeId == 6) {
                        Get.toNamed(AppRouts.getOtherFishDetails(
                            _foundResults[index].id));
                      } else if (_foundResults[index].typeId == 7) {
                        Get.toNamed(
                            AppRouts.getItemsDetails(_foundResults[index].id));
                      } else if (_foundResults[index].typeId == 8) {
                        Get.toNamed(
                            AppRouts.getFeedsDetail(_foundResults[index].id));
                      }
                    },
                    title: BlurContainer(
                        width: Get.width,
                        height: 80,
                        child: Stack(
                          children: [
                            Container(),
                            Positioned(
                                child: Image.network(
                              AppConstents.BASE_URL +
                                  AppConstents.UPLOAD_URL +
                                  _foundResults[index].img!,
                              height: 100.h,
                              width: 100.h,
                            )),
                            Positioned(
                                top: 10.h,
                                left: 110.w,
                                child: textWidget(
                                    text: _foundResults[index].name,
                                    color: Theme.of(context).indicatorColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Positioned(
                                top: 30.h,
                                left: 110.w,
                                child: _foundResults[index].breeder != null
                                    ? textWidget(
                                        text:
                                            '@' + _foundResults[index].breeder,
                                        color: Theme.of(context).splashColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)
                                    : Container()),
                            Positioned(
                                bottom: 10.h,
                                left: 110.w,
                                child: _foundResults[index].price != null
                                    ? textWidget(
                                        text: " ₹   " +
                                            allProducts[index]
                                                .price
                                                .toString() +
                                            '/-',
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)
                                    : Container()),
                          ],
                        )),
                  );
                })
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  SerchTile(
                      name: 'Betta Fishes',
                      count: fishes.productInfoList.length.toString(),
                      pic: 'assets/fishesexample/1.png'),
                  SerchTile(
                      name: 'Other Fishes',
                      count: otherFish.otherFishInfoList.length.toString(),
                      pic: 'assets/fishesexample/allfishes.png'),
                  SerchTile(
                      name: 'Plants',
                      count: plants.plantsInfoList.length.toString(),
                      pic: 'assets/fishesexample/plantaq.png'),
                  SerchTile(
                      name: 'Aqua Items',
                      count: items.itemsInfoList.length.toString(),
                      pic: 'assets/fishesexample/items.png'),
                  SerchTile(
                      name: 'Feeds',
                      count: feeds.feedsInfoList.length.toString(),
                      pic: 'assets/fishesexample/feedinhand.png'),
                ],
              ),
      ),
    );
  }
}

class SerchTile extends StatelessWidget {
  const SerchTile({
    super.key,
    required this.name,
    required this.count,
    required this.pic,
  });
  final String name;
  final String count;
  final String pic;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: BlurContainer(
        width: Get.width,
        height: 140.h,
        radius: 30,
        child: Stack(
          children: [
            Container(),
            Positioned(
                top: 40.h,
                left: 45.w,
                child: textWidget(
                    text: name,
                    color: Theme.of(context).indicatorColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Positioned(
                top: 70.h,
                left: 45.w,
                child: BlurContainer(
                  width: 160,
                  height: 30,
                  radius: 25,
                  child: Center(
                      child: textWidget(
                    text: "$count Products availeble",
                    color: Theme.of(context).primaryColor,
                  )),
                )),
            Positioned(
                top: 0.h,
                right: 0.w,
                child: Image.asset(
                  pic,
                  height: 170.h,
                  width: 170.h,
                ))
          ],
        ),
      ),
    );
  }
}
