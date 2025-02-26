import 'package:betta_store/core/utils/res/responsive.dart';
import 'package:betta_store/features/skeleton/tabview.dart';
import 'package:betta_store/features/skeleton/widgets/bottom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? const DeskTopTab()
        : const BottomView();
  }
}
