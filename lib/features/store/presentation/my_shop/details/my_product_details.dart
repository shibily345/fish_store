import 'package:betta_store/core/constents.dart';
import 'package:betta_store/core/dependencies.dart';
import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/features/shop/betta_fishes/presentation/controller/product_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/cart_controller.dart';
import 'package:betta_store/features/shop/feeds/presentation/controller/feeds_info_controller.dart';
import 'package:betta_store/features/shop/items/presentation/controller/items_info_controller.dart';
import 'package:betta_store/features/shop/fishes/presentation/controller/other_fish_info_controller.dart';
import 'package:betta_store/features/shop/plants/presentation/controller/plants_info_controller.dart';
import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';

import 'package:betta_store/features/store/presentation/my_shop/add/suucess_add_page.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class EditProductPage extends StatefulWidget {
  EditProductPage({super.key, required this.pageId});
  final int pageId;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
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
    var product = allProducts.firstWhere((p) => p.id == widget.pageId);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(IconlyBroken.edit),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          bigSpace,
          bigSpace,
          Divider(),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouts.getProductDetailPage(product.id!));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(AppConstents.BASE_URL +
                                AppConstents.UPLOAD_URL +
                                product.img!),
                            fit: BoxFit.cover)),
                    child: Container(),
                    height: 120.h,
                    width: 120.w,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 190.w,
                      child: textWidget(
                        text: product.name!,
                        maxline: 3,
                        fontSize: 15,
                        color: Theme.of(context).indicatorColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 120,
                      child: textWidget(
                        text: product.breeder!,
                        maxline: 3,
                        fontSize: 12,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.4),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    bigSpace,
                    Container(
                      width: 170,
                      child: textWidget(
                        text: product.description!,
                        maxline: 3,
                        fontSize: 12,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.4),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ]),
          Divider(),
          bigSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  Get.toNamed(AppRouts.getEditProductPagePage(widget.pageId));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      IconlyBroken.edit,
                      color: Theme.of(context).primaryColorDark,
                      size: 20,
                    ),
                    textWidget(
                        text: 'Edit your product',
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 13),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, dynamic> detils = {
                    'product_count':
                        '${allProducts.where((products) => products.breeder == Get.find<UserInfoController>().userModel.name).toList().length - 1}',
                  };
                  Get.find<UserInfoController>()
                      .updateUserProfile(
                          Get.find<UserInfoController>().userModel.id!, detils)
                      .then((value) {
                    print("count updated");
                  });
                  Get.find<ProductInfoController>()
                      .deleteProduct(widget.pageId)
                      .then((value) {
                    Get.to(() => ProductAdded());
                    loadResources();
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      IconlyBroken.delete,
                      color: Theme.of(context).primaryColorDark,
                      size: 20,
                    ),
                    textWidget(
                        text: 'Delete product',
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 13),
                  ],
                ),
              ),
            ],
          ),
          bigSpace,
          Divider(),
          bigSpace,
          ListTile(
            title: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
