import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimPage extends StatefulWidget {
  const LoadingShimPage({super.key});

  @override
  State<LoadingShimPage> createState() => _LoadingShimPageState();
}

class _LoadingShimPageState extends State<LoadingShimPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                height: 110.h,
                width: Get.width,
                color: const Color.fromARGB(0, 255, 255, 255),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: Shimmer.fromColors(
                        baseColor: Theme.of(context).primaryColorLight,
                        highlightColor: Colors.grey[700]!,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 30.h,
                      width: 243.w,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[700]!,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 120.w,
                  bottom: 20.h,
                  child: SizedBox(
                      width: 100.h,
                      height: 40.w,

                      // padding: EdgeInsets.all(value),
                      child: Padding(
                        padding: EdgeInsets.all(3.0.w),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[800]!,
                          highlightColor: Colors.grey[700]!,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                color: Colors.black),
                          ),
                        ),
                      ))),
            ],
          );
        },
      ),
    );
  }
}
