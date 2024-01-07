import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BreedersDetailsWidget extends StatelessWidget {
  const BreedersDetailsWidget({super.key, required this.userInfo});
  final UserModel userInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      width: Get.width,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).splashColor,
            height: 70.h,
            width: Get.width,
          ),
          userInfo.sellproduct == 0
              ? CircleAvatar(
                  backgroundColor: Colors.amber,
                  foregroundColor: Theme.of(context).indicatorColor,
                  radius: 40.h,
                  child: const FaIcon(FontAwesomeIcons.user),
                )
              : Positioned(
                  left: 30.w,
                  top: 10.h,
                  child: CachedNetworkImage(
                    height: 100.h,
                    width: 100.w,
                    imageUrl: AppConstents.BASE_URL +
                        AppConstents.UPLOAD_URL +
                        userInfo.logo!,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
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
                ),
          // Positioned(
          //     left: 20.w,
          //     top: 50.h,
          //     child: IconButton(
          //         onPressed: () {
          //           Get.back();
          //         },
          //         icon: const Icon(Icons.arrow_back_ios_new_rounded))),
          Positioned(
            left: 140.w,
            top: 40.h,
            child: textWidget(
              text: "@${userInfo.name}",
              fontSize: 17,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          Positioned(
            left: 140.w,
            top: 75.h,
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                ),
                textWidget(
                  text: "  ${userInfo.location}",
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
