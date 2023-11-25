import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 50).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _colorAnimation = Tween<double>(begin: 1, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  bool _expanded = false;

  void _expand() {
    setState(() {
      _expanded = true;
    });
  }

  Color shadeColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                bgc: Theme.of(context).primaryColorDark,
                image: 'assets/ui_elementsbgon/betta.png',
                subtitle:
                    'Explore stunning betta fishes each a living \nwork of art',
                title: 'Discover Exotic Betta Fishes',
              ),
              OnboardingPage(
                bgc: Theme.of(context).primaryColorDark,
                image: 'assets/ui_elementsbgon/b1.png',
                subtitle:
                    'Dive into elegance with rare fishes and lush aquatic greens',
                title: 'Explore Aquatic Elegance',
              ),
              OnboardingPage(
                bgc: Theme.of(context).primaryColorDark,
                image: 'assets/ui_elementsbgon/b2.png',
                subtitle:
                    ' Join us to showcase and sell your exquisite fishes and plants. Turn your passion into a thriving aquatic marketplace',
                title: 'Sell Your Aquatic Creativity',
              ),
            ],
          ),
          Positioned(
              top: 50,
              left: 30,
              right: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/bstore logos/labelWhite.png',
                    color: Theme.of(context).primaryColor,
                    width: 120.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRouts.getInPage());
                    },
                    child: textWidget(
                        text: "Skip",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).indicatorColor.withOpacity(0.4)),
                  )
                ],
              )),
          Positioned(
            bottom: 40.0,
            right: 40.0,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value * 1.4,
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: shadeColor, // Match the color of the next page
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 30.0,
            right: 30.0,
            child: GestureDetector(
              onTap: () {
                _currentPage < 2
                    ? _animateButton()
                    : Get.toNamed(AppRouts.signUpPage);
              },
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 400),
                width: _currentPage == 2 ? 150 : 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).splashColor,
                ),
                child: Center(
                  child: _currentPage == 2
                      ? textWidget(
                          overFlow: TextOverflow.clip,
                          text: "Sign up ",
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).primaryColor)
                      : Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 10.0,
                  width: (index == _currentPage) ? 30.0 : 10.0,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: (index == _currentPage)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _animateButton() {
    if (_currentPage == 0) {
      shadeColor = Theme.of(context).primaryColorDark;
    } else if (_currentPage == 1) {
      shadeColor = Theme.of(context).primaryColorDark;
    }

    _animationController.forward().whenComplete(() {
      _animationController.reverse();
      _pageController.nextPage(
        duration: Duration(milliseconds: 10),
        curve: Curves.easeInOut,
      );
    });
  }
}

class OnboardingPage extends StatelessWidget {
  final String subtitle;
  final Color bgc;
  final String title;
  final String image;

  const OnboardingPage({
    required this.subtitle,
    required this.title,
    required this.image,
    required this.bgc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgc,
      child: Stack(
        children: [
          Positioned(
            top: 160.h,
            left: 30.w,
            right: 30.w,
            child: Image.asset(
              image,
              height: 400,
              width: Get.width,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          Positioned(
            top: 160.h,
            left: 30.w,
            right: 30.w,
            child: AmbiendContainer(
              height: 400,
              color: Colors.transparent,
              width: Get.width,
              child: Image.asset(image),
            ),
          ),
          Positioned(
            top: 580.h,
            left: 40.w,
            child: SizedBox(
              width: 300.w,
              child: textWidget(
                maxline: 2,
                text: title,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
          Positioned(
            top: 660.h,
            left: 40.w,
            child: SizedBox(
              width: 330.w,
              child: textWidget(
                  maxline: 5,
                  text: subtitle,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).indicatorColor.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
