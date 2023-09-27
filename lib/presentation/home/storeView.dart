import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/items_info_controller.dart';
import 'package:betta_store/infrastructure/controller/feeds_info_controller.dart';
import 'package:betta_store/infrastructure/controller/other_fish_info_controller.dart';
import 'package:betta_store/infrastructure/controller/plants_info_controller.dart';
import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/presentation/helps/widgets/loading.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key, required this.tabcontroller});
  final TabController tabcontroller;
  @override
  State<StoreView> createState() => _StoreViewState();
}

enum SortOption { priceHighToLow, priceLowToHigh, newest, oldest }

class _StoreViewState extends State<StoreView> {
  SortOption _selectedSortOption = SortOption.newest;
  Future<void> _loadResources() async {
    _selectedSortOption = SortOption.newest;
    await Get.find<ProductInfoController>().getProductInfoList();
    await Get.find<PlantsInfoController>().getPlantsInfoList();
    await Get.find<OtherFishInfoController>().getOtherFishInfoList();
    await Get.find<ItemsInfoController>().getItemsInfoList();
    await Get.find<FeedsInfoController>().getfeedsInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(builder: (
      productInfo,
    ) {
      void _sortData(SortOption selectedOption) {
        setState(() {
          switch (selectedOption) {
            case SortOption.priceHighToLow:
              productInfo.productInfoList
                  .sort((a, b) => b.price.compareTo(a.price));
              break;
            case SortOption.priceLowToHigh:
              productInfo.productInfoList
                  .sort((a, b) => a.price.compareTo(b.price));
              break;
            case SortOption.newest:
              productInfo.productInfoList
                  .sort((a, b) => b.createdAt.compareTo(a.createdAt));
              break;
            case SortOption.oldest:
              productInfo.productInfoList
                  .sort((a, b) => a.createdAt.compareTo(b.createdAt));
              break;
          }
        });
      }

      return productInfo.isLoaded
          ? DefaultTabController(
              length: 5,
              child: TabBarView(controller: widget.tabcontroller, children: [
                RefreshIndicator(
                  onRefresh: _loadResources,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 60.h,
                          child: DropdownButton<SortOption>(
                            focusColor: Theme.of(context).splashColor,
                            padding: const EdgeInsets.all(10),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20),
                            underline: Container(),
                            hint: textWidget(
                                text: "Sortby",
                                color: Theme.of(context).primaryColor),
                            value: _selectedSortOption,
                            onChanged: (SortOption? newValue) {
                              setState(() {
                                _selectedSortOption = newValue!;
                                _sortData(_selectedSortOption);
                              });
                            },
                            items: SortOption.values.map((SortOption option) {
                              return DropdownMenuItem<SortOption>(
                                value: option,
                                child: Text(option.toString().split('.').last),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: productInfo.productInfoList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            mainAxisSpacing: 3.0,
                            crossAxisSpacing: 3.0,
                          ),
                          itemBuilder: (context, index) {
                            return Stack(
                              //   fit: StackFit.loose,
                              children: [
                                Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      bigSpace,
                                      bigSpace,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 175.w,
                                            height: 70.h,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).splashColor,

                                              // ),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20.h),
                                                  topRight:
                                                      Radius.circular(20.h),
                                                  bottomRight:
                                                      Radius.elliptical(
                                                          180.h, 160.h),
                                                  topLeft: Radius.elliptical(
                                                      180.h, 160.h)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).splashColor,
                                      child: IconButton(
                                          enableFeedback: true,
                                          onPressed: () {
                                            Get.toNamed(AppRouts.getfishDetails(
                                                productInfo
                                                    .productInfoList[index]
                                                    .id!));
                                          },
                                          icon: Icon(
                                            Iconsax.shopping_cart,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                    )),
                                Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                        enableFeedback: true,
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Theme.of(context).primaryColor,
                                        ))),
                                Positioned(
                                  bottom: 20.h,
                                  left: 30.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 120.w,
                                        child: textWidget(
                                            text: productInfo
                                                .productInfoList[index].name!,
                                            color: Theme.of(context)
                                                .indicatorColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      textWidget(
                                          text: productInfo
                                                      .productInfoList[index]
                                                      .breeder ==
                                                  ''
                                              ? "@Devine_Bettas"
                                              : '@${productInfo.productInfoList[index].breeder!}',
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  //top: 10,
                                  left: 20,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRouts.getfishDetails(
                                          productInfo
                                              .productInfoList[index].id!));
                                    },
                                    child: Image.network(
                                      AppConstents.BASE_URL +
                                          AppConstents.UPLOAD_URL +
                                          productInfo
                                              .productInfoList[index].img!,
                                      width: 150.w,
                                      height: 150.h,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<PlantsInfoController>(
                  builder: (
                    productInfo,
                  ) {
                    return productInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: productInfo.plantsInfoList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRouts.getPlantDetails(
                                              productInfo
                                                  .plantsInfoList[index].id));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        productInfo
                                                            .plantsInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 6, left: 30),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).splashColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: productInfo
                                                      .plantsInfoList[index]
                                                      .name!,
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: CustomeLoader(),
                          );
                  },
                ),
                GetBuilder<OtherFishInfoController>(
                  builder: (
                    ofProductInfo,
                  ) {
                    return ofProductInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: ofProductInfo.otherFishInfoList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0.w),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRouts.getOtherFishDetails(
                                                  ofProductInfo
                                                      .otherFishInfoList[index]
                                                      .id));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.w),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        ofProductInfo
                                                            .otherFishInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 6.h, left: 30.w),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).splashColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: ofProductInfo
                                                      .otherFishInfoList[index]
                                                      .name!,
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const CustomeLoader();
                  },
                ),
                GetBuilder<ItemsInfoController>(
                  builder: (
                    productInfo,
                  ) {
                    return productInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: productInfo.itemsInfoList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRouts.getItemsDetails(
                                              productInfo
                                                  .itemsInfoList[index].id));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        productInfo
                                                            .itemsInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 6, left: 30),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).splashColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: productInfo
                                                      .itemsInfoList[index]
                                                      .name!,
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const CustomeLoader();
                  },
                ),
                GetBuilder<FeedsInfoController>(
                  builder: (
                    productInfo,
                  ) {
                    return productInfo.isLoaded
                        ? RefreshIndicator(
                            onRefresh: _loadResources,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: productInfo.feedsInfoList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing: 3.0,
                                crossAxisSpacing: 3.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 190.w,
                                  height: 190.h,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // color: Color.fromARGB(236, 217, 16, 16),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRouts.getFeedsDetail(
                                              productInfo
                                                  .feedsInfoList[index].id));
                                        },
                                        child: Container(
                                          height: 110.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstents.BASE_URL +
                                                        AppConstents
                                                            .UPLOAD_URL +
                                                        productInfo
                                                            .feedsInfoList[
                                                                index]
                                                            .img!,
                                                  ))),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 6, left: 30),
                                        width: 170.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).splashColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight:
                                                  Radius.elliptical(180, 160),
                                              topLeft:
                                                  Radius.elliptical(180, 160)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: textWidget(
                                                  text: productInfo
                                                      .feedsInfoList[index]
                                                      .name!,
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            textWidget(
                                                text: "@Devine_Bettas",
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const CustomeLoader();
                  },
                ),
              ]),
            )
          : const Center(
              child: CustomeLoader(),
            );
    });
  }
}
