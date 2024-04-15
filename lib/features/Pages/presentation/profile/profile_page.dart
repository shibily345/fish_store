import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/privacy_terms.dart';
import 'package:betta_store/features/Pages/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/Pages/domain/controller/auth_controller.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/presentation/profile/widgets/option_tiles.dart';
import 'package:betta_store/features/Pages/presentation/profile/widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLogedIn();
    if (userLoggedIn) {
      Get.find<UserInfoController>().getUserInfo();
      print("UserLogged");
    }
    return Scaffold(
      body: GetBuilder<UserInfoController>(
        builder: (userInfo) {
          if (userLoggedIn == true) {
            return (userInfo.isLoading
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        UserDetailsWidget(userInfo: userInfo.userModel),
                        const OptionTilesWidget(),
                        const Center(child: PrivecyLabelWidget())
                      ],
                    ),
                  )
                : const Center(child: CustomeLoader()));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/ui_elementsbgon/login.json'),
                smallSpace,
                Center(
                    child: MaterialButton(
                  height: 60,
                  minWidth: 160,
                  onPressed: () {
                    Get.toNamed(AppRouts.signUpPage);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  color: Theme.of(context).primaryColor,
                  child: textWidget(
                      text: "Login", color: Colors.black, fontSize: 16),
                )),
              ]
                  .animate(interval: 100.ms)
                  .fade()
                  .fadeIn(curve: Curves.easeInOut),
            );
          }
        },
      ),
    );
  }
}
