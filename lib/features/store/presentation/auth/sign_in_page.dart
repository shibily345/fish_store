import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/privacy_terms.dart';
import 'package:betta_store/features/store/domain/controller/auth_controller.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/store/presentation/auth/reset_password.dart';
import 'package:betta_store/features/store/presentation/auth/widgets/sign_in_fields.dart';
import 'package:betta_store/features/store/presentation/auth/widgets/top_contents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void _login(AuthController auth) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        showCustumeSnackBar("Enter Your Name", title: "Name is Empty");
      } else if (password.isEmpty) {
        showCustumeSnackBar("Enter Your Password", title: "Password is Empty");
      } else if (password.length < 6) {
        showCustumeSnackBar("Enter minimum 6 letters in Password",
            title: "Passwor Not valid");
      } else {
        auth.login(phone, password).then((status) {
          if (status.isSuccess) {
            print("success...");
            Get.toNamed(AppRouts.getSplash());
          } else {
            print("$phone--------$password");
            showCustumeSnackBar(
                "${status.message} Report now Contact bettaStore team");
          }
        });
      }
    }

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TopContents(),
            SignInFieldWidget(
                phoneController: phoneController,
                passwordController: passwordController),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 18.0.w),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const PasswordResetPage());
                      print("password marannooy");
                    },
                    child: textWidget(
                        text: "Forgot your Password? ",
                        color: Theme.of(context).indicatorColor),
                  ),
                )),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                width: MediaQuery.of(context).size.width * 0.4,

                height: 50,
                // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                child: GetBuilder<AuthController>(
                  builder: (auth) {
                    return MaterialButton(
                      onPressed: () {
                        _login(auth);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Theme.of(context).primaryColor,
                      child: !auth.isLoading
                          ? textWidget(
                              text: "Login",
                              color: Theme.of(context).indicatorColor,
                              fontSize: 16)
                          : Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              color: Theme.of(context).primaryColorDark,
                            )),
                    );
                  },
                ),
              ),
            )),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Center(
                    child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRouts.signUpPage);
                  },
                  child: textWidget(
                      maxline: 2,
                      text: "Don't have an account ?\n   Click here to Create.",
                      color: Theme.of(context).indicatorColor),
                )),
              ),
            ),
            bigSpace,
            bigSpace,
            bigSpace,
            bigSpace,
            const Center(child: PrivecyLabelWidget())
          ].animate(interval: 100.ms).fade().fadeIn(curve: Curves.easeInOut),
        ));
  }
}
