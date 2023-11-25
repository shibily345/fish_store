import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BreederListWidget extends StatefulWidget {
  const BreederListWidget({super.key});

  @override
  State<BreederListWidget> createState() => _BreederListWidgetState();
}

class _BreederListWidgetState extends State<BreederListWidget> {
  @override
  void initState() {
    Get.find<UserInfoController>().getBreedersList();
    super.initState();
  }

  Future<void> _loadResources() async {
    Get.find<UserInfoController>().getBreedersList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserInfoController>(builder: (breeders) {
      List<dynamic> _filteredBreedersList = breeders.breedersList
          .where((breeder) => breeder.sellproduct == 1)
          .toList();
      return breeders.isLoaded
          ? RefreshIndicator(
              onRefresh: _loadResources,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),

                itemCount: _filteredBreedersList
                    .length, // Replace with the number of items you have
                itemBuilder: (BuildContext context, int index) {
                  // Replace this with your grid item widget
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRouts.getBreederDetails(
                          _filteredBreedersList[index].id!));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 180,
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
                                      _filteredBreedersList[index].logo!,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) => Center(
                                      child: CustomeLoader(
                                    bg: Colors.transparent,
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                smallwidth,
                                textWidget(
                                    text: _filteredBreedersList[index].name,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).indicatorColor),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 100,
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                textWidget(
                                    text: _filteredBreedersList[index].location,
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
                              Icon(Icons.cases_sharp),
                              textWidget(
                                  text:
                                      " ${_filteredBreedersList[index].productCount} Products",
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).indicatorColor),
                            ]),
                          ),
                          Positioned(
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
            )
          : Center(child: CustomeLoader());
    });
  }
}
