import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/review_controller.dart';
import 'package:betta_store/features/store/presentation/order/order_progress/widgets/write_riview_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OwnReviweBoxWidget extends StatelessWidget {
  const OwnReviweBoxWidget({
    super.key,
    this.order,
    this.product,
  });

  final dynamic order;
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(builder: (review) {
      List<dynamic> productReviews = review.allReviews
          .where((review) => review.userId == order.userId)
          .toList();
      return productReviews.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap:
                  true, // Setting shrinkWrap to true enables the ListView to take only the space it needs.
              physics: const ClampingScrollPhysics(),
              itemCount: productReviews.length,
              itemBuilder: (context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        text: "My review",
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.6),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    smallSpace,
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(
                                  text: productReviews[index].user!.name!,
                                  color: Theme.of(context).indicatorColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                RatingBarIndicator(
                                  rating: double.parse(
                                      productReviews[index].rating.toString()),
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Theme.of(context).indicatorColor,
                                    size: 10,
                                  ),
                                  itemSize: 20,
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 18.0.w, bottom: 20.h),
                                child: CachedNetworkImage(
                                  imageUrl: AppConstents.BASE_URL +
                                      AppConstents.UPLOAD_URL +
                                      productReviews[index].img!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 130,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider,
                                        ),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0.w, bottom: 20.h, right: 10.w),
                                child: SizedBox(
                                  width: 190.w,
                                  child: textWidget(
                                    maxline: 100,
                                    text: productReviews[index].comment!,
                                    color: Theme.of(context).indicatorColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
          : WriteAreviewWidget(order: order, product: product);
    });
  }
}
