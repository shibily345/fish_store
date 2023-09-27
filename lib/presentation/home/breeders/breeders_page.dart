import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:bottom_bar_matu/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BreedersPage extends StatefulWidget {
  const BreedersPage({super.key});

  @override
  State<BreedersPage> createState() => _BreedersPageState();
}

class _BreedersPageState extends State<BreedersPage> {
  PageController pageController = PageController(viewportFraction: 0.88);

  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  var _height = 220.h;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Container(
            height: 230,
            child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, position) {
                  return _buildPageItem(position);
                }),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
            ),
            itemCount: 12, // Replace with the number of items you have
            itemBuilder: (BuildContext context, int index) {
              // Replace this with your grid item widget
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child:
                    BlurContainer(child: Container(), width: 200, height: 200),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix - Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix - Matrix4.diagonal3Values(1, currScale, 1);
      matrix - Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix - Matrix4.diagonal3Values(1, currScale, 1);
      matrix - Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix - Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colorYellow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(),
            width: 400.w,
            height: 200,
          ),
        ],
      ),
    );
  }
}
