// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import 'package:betta_store/infrastructure/controller/product_info_controller.dart';
import 'package:betta_store/infrastructure/models/fish_detile_model.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:betta_store/presentation/helps/widgets/video_play.dart';
import 'package:betta_store/utils/theme/constants.dart';

import '../../core/constents.dart';

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
    final PageController controller = PageController(initialPage: 0);
    final List<Widget> pageContents = [
      buildPageView1(1, context),
      buildPageView2(2),
      buildPageView3(3),
    ];
    return Column(
      children: [
        Container(
          height: 620.h,
          width: Get.width,
          child: PageView.builder(
              controller: controller,
              itemCount: 3,
              itemBuilder: (context, position) {
                return Container(
                    height: 300.h,
                    width: Get.width,
                    child: pageContents[position]);
              }),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: pageContents.length,
          effect: SlideEffect(
              spacing: 8.0,
              radius: 4.0,
              dotWidth: 24.0,
              dotHeight: 10.0,
              paintStyle: PaintingStyle.stroke,
              strokeWidth: 1.5,
              dotColor: Colors.grey,
              activeDotColor: Color.fromARGB(255, 40, 97, 53)),
        )
      ],
    );
  }

  Widget buildPageView1(int position, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 28.h, left: 18.w, right: 18.w),
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          Stack(
            children: [
              Container(
                height: 500.h,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.h),
                    image: DecorationImage(
                        image: AssetImage('assets/fishesexample/fishbg1.png'),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  top: 20.h,
                  //  left: 20.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Stack(
                      children: [
                        Image.network(
                          AppConstents.BASE_URL +
                              AppConstents.UPLOAD_URL +
                              productInfo.img!,
                          width: 350.w,
                          height: 320.h,
                        ),
                        BlurContainer(
                          radius: 30.h,
                          child: Image.network(
                            AppConstents.BASE_URL +
                                AppConstents.UPLOAD_URL +
                                productInfo.img!,
                            width: 290.w,
                            height: 290.h,
                          ),
                          width: 350.w,
                          height: 320.h,
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 20.h,
                  left: 10.w.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlurContainer(
                          child: Column(
                            children: [
                              textWidget(
                                  text: 'Age : ',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              RichTextWidget(texts: [
                                TextSpan(
                                    text: ' 3 \n',
                                    style: TextStyle(
                                      fontSize: 35,
                                    )),
                                TextSpan(
                                    text: 'Months',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ))
                              ])
                            ],
                          ),
                          width: 110.w,
                          height: 90.h),
                      SizedBox(
                        width: 10.w,
                      ),
                      BlurContainer(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              textWidget(
                                  text: 'Health : ',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              RichTextWidget(texts: [
                                TextSpan(
                                    text: ' ⭐ \n',
                                    style: TextStyle(
                                      height: 1.4.h,
                                      fontSize: 25,
                                    )),
                                TextSpan(
                                    text: 'Great',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))
                              ])
                            ],
                          ),
                          width: 110.w,
                          height: 90.h),
                      SizedBox(
                        width: 10.w,
                      ),
                      BlurContainer(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              textWidget(
                                  text: 'Rating : ',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              textWidget(
                                text: '3.6',
                                fontSize: 25,
                                color: Theme.of(context).indicatorColor,
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: 4,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 12.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 3,
                                ),
                                onRatingUpdate: (rating) {
                                  // This callback is triggered whenever the rating changes
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                          width: 110.w,
                          height: 90.h),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}

Widget buildPageView2(int position) {
  return Padding(
    padding: EdgeInsets.only(top: 28.h, left: 18.w, right: 18.w),
    child: Column(
      children: [
        SizedBox(
          height: 80.h,
        ),
        GetBuilder<ProductInfoController>(builder: (productInfo) {
          return Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 500.h,
            width: Get.width,
            decoration: BoxDecoration(
              color: secondaryColor60DarkTheme,
              borderRadius: BorderRadius.circular(30),
            ),
            child: VideoPlayView(
              url: 'assets/fishesexample/egVideo.mp4',
            ),
          );
        })
      ],
    ),
  );
}

Widget buildPageView3(int position) {
  return Padding(
    padding: EdgeInsets.only(top: 28.h, left: 18, right: 18.w),
    child: Column(
      children: [
        SizedBox(
          height: 80.h,
        ),
        GetBuilder<ProductInfoController>(builder: (productInfo) {
          return Container(
            height: 500.h,
            width: Get.width,
            decoration: BoxDecoration(
                color: secondaryColor60DarkTheme,
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage('assets/fishesexample/fishbg1.png'),
                    fit: BoxFit.cover)),
          );
        })
      ],
    ),
  );
}

class VideoPlayView extends StatefulWidget {
  const VideoPlayView({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<VideoPlayView> createState() => _VideoPlayViewState();
}

class _VideoPlayViewState extends State<VideoPlayView> {
  late VideoPlayerController _vpController;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();

    _vpController = VideoPlayerController.asset(widget.url);

    _chewieController = ChewieController(
      zoomAndPan: true,
      looping: true,
      showControlsOnInitialize: false,
      autoPlay: true,
      autoInitialize: true,
      videoPlayerController: _vpController,
      aspectRatio: 2 / 3,
    );
    @override
    void dispose() {
      _vpController.dispose();
      _chewieController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Chewie(controller: _chewieController),
    );
  }
}
