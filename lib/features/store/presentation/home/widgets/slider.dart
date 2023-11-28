import 'dart:async';

import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/features/store/domain/controller/ad_list_controller.dart';
import 'package:betta_store/features/store/domain/data/repository/ad_list_repo.dart';
import 'package:betta_store/features/store/domain/models/ad_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdSliders extends StatefulWidget {
  const AdSliders({super.key});

  @override
  State<AdSliders> createState() => _AdSlidersState();
}

class _AdSlidersState extends State<AdSliders> {
  int _currentPage = 0;
  List<String> imgList = [];
  PageController _pageController = PageController();
  // static final customeCacheManager = Basecache;
  @override
  void initState() {
    super.initState();
    // Auto-play the slider every 3 seconds
    Timer.periodic(Duration(seconds: 6), (Timer timer) {
      if (_currentPage < Get.find<AdlistController>().ads.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    Get.find<AdlistController>().getAllads();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdlistController>(builder: (ad) {
      List<AdListModel> adsfirst = ad.ads.reversed.toList();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200.0, width: Get.width, // Adjust the height as needed
            child: PageView.builder(
              itemCount: ad.ads.length,
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildImageSliderItem(adsfirst[index].img!, index);
              },
            ),
          ),
          SizedBox(height: 10.0),
          _buildIndicators(ad.ads.length),
        ],
      );
    });
  }

  Widget _buildImageSliderItem(String imageUrl, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
            }
            return Center(
              child: SizedBox(
                height: Curves.easeInOut.transform(value) * 200.0,
                width: Curves.easeInOut.transform(value) *
                    Get.width, // Adjust the width as needed
                child: child,
              ),
            );
          },
          child: CachedNetworkImage(
            // cacheManager: (),
            key: UniqueKey(),
            imageUrl:
                AppConstents.BASE_URL + AppConstents.UPLOAD_URL + imageUrl,
            imageBuilder: (context, imageProvider) => ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            placeholder: (context, url) => Center(
                child: CustomeLoader(
              bg: Colors.transparent,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }

  Widget _buildIndicators(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _currentPage == index ? 16.0 : 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _currentPage == index
                ? Theme.of(context).primaryColor
                : Theme.of(context).indicatorColor.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
