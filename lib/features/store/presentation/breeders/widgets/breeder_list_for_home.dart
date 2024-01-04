import 'dart:async';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeBreederListWidget extends StatefulWidget {
  const HomeBreederListWidget({super.key});

  @override
  State<HomeBreederListWidget> createState() => _HomeBreederListWidgetState();
}

class _HomeBreederListWidgetState extends State<HomeBreederListWidget> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int length = 0;
  @override
  void initState() {
    super.initState();
    Get.find<UserInfoController>().getBreedersList();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.page == length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadResources() async {
    Get.find<UserInfoController>().getBreedersList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserInfoController>(builder: (breeders) {
      List<dynamic> filteredBreedersList = breeders.breedersList
          .where((breeder) => breeder.productCount > 0)
          .toList();
      length = filteredBreedersList.length;
      return breeders.isLoaded
          ? RefreshIndicator(
              onRefresh: _loadResources,
              child: SizedBox(
                height: 200.h,
                child: Center(
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredBreedersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouts.getBreederDetails(
                              filteredBreedersList[index].id!));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, left: 15),
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 20,
                                top: 10,
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      height: 60.h,
                                      width: 60.h,
                                      imageUrl: AppConstents.BASE_URL +
                                          AppConstents.UPLOAD_URL +
                                          filteredBreedersList[index].logo!,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        backgroundImage: imageProvider,
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[800]!,
                                        highlightColor: Colors.grey[700]!,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              color: Colors.black),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    smallwidth,
                                    textWidget(
                                        text: filteredBreedersList[index].name,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).indicatorColor),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 100,
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined),
                                    textWidget(
                                        text: filteredBreedersList[index]
                                            .location,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.8)),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 135,
                                child: Row(children: [
                                  const Icon(Icons.cases_sharp),
                                  textWidget(
                                      text:
                                          " ${filteredBreedersList[index].productCount} Products",
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).indicatorColor),
                                ]),
                              ),
                              const Positioned(
                                  right: 20,
                                  top: 100,
                                  child: Icon(
                                    Icons.keyboard_double_arrow_right_rounded,
                                    size: 60,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : Center(child: Container());
    });
  }
}
