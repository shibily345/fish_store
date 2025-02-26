import 'package:betta_store/features/Pages/presentation/product_detils/desktop_detail_sc.dart';
import 'package:betta_store/features/Pages/presentation/product_detils/detile_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/res/responsive.dart';

class ProductDetailsscreen extends StatelessWidget {
  ProductDetailsscreen({super.key, required this.pageId});
  int pageId;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: FishDetilsPage(
        pageId: pageId,
      ),
      tablet: FishDetilsPage(
        pageId: pageId,
      ),
      desktop: DeskTopProductDetails(
        pageId: pageId,
      ),
    );
  }
}
