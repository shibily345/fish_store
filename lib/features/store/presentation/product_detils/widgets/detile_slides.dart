// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import 'package:betta_store/features/store/domain/models/products_model.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/core/utils/widgets/video_play.dart';
import 'package:betta_store/core/utils/theme/constants.dart';

class DetailSlides extends StatelessWidget {
  dynamic productInfo;
  int index;

  DetailSlides({
    Key? key,
    required this.productInfo,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String url = productInfo.video != "" ||
            productInfo.typeId == 4 ||
            productInfo.typeId == 6
        ? AppConstents.BASE_URL + AppConstents.UPLOAD_URL + productInfo.video!
        : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4";
    final PageController controller = PageController(initialPage: 0);
    final List<Widget> pageContents = [
      buildImagePage(1, context),
      if (productInfo.typeId == 4 || productInfo.typeId == 6)
        buildVideoPage(context, url),
    ];
    return Column(
      children: [
        SizedBox(
          height: 520.h,
          width: Get.width,
          child: PageView.builder(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              controller: controller,
              itemCount:
                  productInfo.typeId == 4 || productInfo.typeId == 6 ? 2 : 1,
              itemBuilder: (context, position) {
                return SizedBox(
                    height: 300.h,
                    width: Get.width,
                    child: pageContents[position]);
              }),
        ),
        if (productInfo.typeId == 4 || productInfo.typeId == 6)
          SmoothPageIndicator(
            controller: controller,
            count: pageContents.length,
            effect: SlideEffect(
                spacing: 8.0,
                radius: 4.0,
                dotWidth: 14.0,
                dotHeight: 10.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: Theme.of(context).primaryColor),
          )
        else
          Container()
      ],
    );
  }

  Padding buildVideoPage(BuildContext context, String url) {
    return Padding(
      padding:
          EdgeInsets.only(top: 88.h, left: 18.w, right: 18.w, bottom: 10.h),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: 440.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: VideoPlayView(
          url: url,
        ),
      ),
    );
  }

  Widget buildImagePage(int position, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.only(top: 68.h, left: 18.w, right: 18.w, bottom: 10.h),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              width: 350.w,
              height: 320.h,
              imageUrl: AppConstents.BASE_URL +
                  AppConstents.UPLOAD_URL +
                  productInfo.img!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
                child: AmbiendContainer(
                  color: Colors.transparent,
                  child: CachedNetworkImage(
                    width: 350.w,
                    height: 320.h,
                    imageUrl: AppConstents.BASE_URL +
                        AppConstents.UPLOAD_URL +
                        productInfo.img!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                        child: CustomeLoader(
                      bg: Colors.transparent,
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  width: 300,
                  height: 300,
                ),
              ),
              placeholder: (context, url) => Center(
                  child: CustomeLoader(
                bg: Colors.transparent,
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            if (productInfo.typeId == 4 || productInfo.typeId == 6)
              textWidget(
                text: "Swipe to See Video >",
                color: Theme.of(context).indicatorColor.withOpacity(0.4),
              )
          ],
        ),
      ),
    );
  }
}
