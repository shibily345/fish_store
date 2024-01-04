import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';

import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/breeders/widgets/breeder_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BreederDetailsPage extends StatefulWidget {
  final int pageId;
  const BreederDetailsPage({super.key, required this.pageId});

  @override
  State<BreederDetailsPage> createState() => _BreederDetailsPageState();
}

class _BreederDetailsPageState extends State<BreederDetailsPage> {
  var fishes = Get.find<ProductInfoController>();
  var plants = Get.find<PlantsInfoController>();
  var otherFish = Get.find<OtherFishInfoController>();
  var items = Get.find<ItemsInfoController>();
  var feeds = Get.find<FeedsInfoController>();
  List<dynamic> allProducts = [];
  Future<void> _addall() async {
    setState(() {});
  }

  @override
  void initState() {
    // FocusScope.of(context).requestFocus(serchFocus);
    _addall();
    allProducts.addAll(fishes.productInfoList);
    allProducts.addAll(plants.plantsInfoList);
    allProducts.addAll(otherFish.otherFishInfoList);
    allProducts.addAll(items.itemsInfoList);
    allProducts.addAll(feeds.feedsInfoList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var breeder = Get.find<UserInfoController>()
        .breedersList
        .firstWhere((p) => p.id == widget.pageId);
    List<dynamic> productInfo = allProducts
        .where((products) => products.breeder == breeder.name)
        .toList();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: loadResources,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BreedersDetailsWidget(userInfo: breeder),
            smallSpace,
            Expanded(
              flex: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: productInfo.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.5, // Number of columns
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRouts.getProductDetailPage(
                            productInfo[index].id));
                      },
                      child: Container(
                        width: 190.w,
                        height: 250.h,
                        margin: EdgeInsets.all(5.0.h),
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
                                  productInfo[index].img!,
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
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[800]!,
                                highlightColor: Colors.grey[700]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Colors.black),
                                ),
                              ),
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
                                        text: productInfo[index].name!,
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  textWidget(
                                      text:
                                          '₹ ${productInfo[index].price!} /pair',
                                      color: Theme.of(context).indicatorColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  textWidget(
                                      text: productInfo[index].breeder == ''
                                          ? "@Devine_Bettas"
                                          : '@${productInfo[index].breeder!}',
                                      color: Theme.of(context).indicatorColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300),
                                ]
                                    .animate(interval: 250.ms)
                                    .fade()
                                    .slideY(curve: Curves.easeInOut),
                              ),
                            ),
                          ]
                              .animate(interval: 150.ms)
                              .fade()
                              .fadeIn(curve: Curves.easeInOutExpo),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
