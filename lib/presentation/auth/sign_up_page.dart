import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/auth_controller.dart';
import 'package:betta_store/infrastructure/models/signup_body_model.dart';
import 'package:betta_store/presentation/helps/widgets/containers.dart';
import 'package:betta_store/presentation/helps/widgets/custom.dart';
import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    void _registration() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String mobile = mobileController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      if (name.isEmpty) {
        showCustumeSnackBar("Enter Your Name", title: "Name is Empty");
      } else if (mobile.isEmpty) {
        showCustumeSnackBar("Enter Your Phone No", title: "Phone No is Empty");
      } else if (email.isEmpty) {
        showCustumeSnackBar("Enter Your Email", title: "Email is Empty");
      } else if (!GetUtils.isEmail(email)) {
        showCustumeSnackBar("Enter Your Valid Email",
            title: "Email is not valid");
      } else if (password.isEmpty) {
        showCustumeSnackBar("Enter Your Password", title: "Password is Empty");
      } else if (password.length < 6) {
        showCustumeSnackBar("Enter minimum 6 letters in Password",
            title: "Passwor Not valid");
      } else if (password != confirmPassword) {
        showCustumeSnackBar("Password Not match Re-enter confirm password",
            title: "Password Not match");
      } else {
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: mobile,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("success...");
            Get.toNamed(AppRouts.getSplash());
          } else {
            showCustumeSnackBar(status.message);
          }
        });
        print(signUpBody.toString());
      }
    }

    return Scaffold(body: GetBuilder<AuthController>(
      builder: (authController) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Form(
                key: _formkey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    bigSpace, bigSpace,
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: SizedBox(
                          width: 300,
                          height: 170,
                          //decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(40),
                          //border: Border.all(color: Colors.blueGrey)),
                          child: Image.asset(
                            color: Theme.of(context).indicatorColor,
                            'assets/bstore logos/fullLogoWhite.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 50.h,
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          controller: nameController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'User / Store Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).indicatorColor,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 50.h,
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          controller: mobileController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'Mobile',
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 50.h,
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          controller: emailController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).indicatorColor,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 50.h,
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: ' Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: BlurContainer(
                        width: Get.width,
                        height: 50.h,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          obscureText: true,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                              hintText: 'Confirm Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),

                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 20.0.w),
                      child: SizedBox(
                        // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                        width: MediaQuery.of(context).size.width * 0.4,

                        height: 50,
                        // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                        child: MaterialButton(
                          onPressed: () {
                            _registration();
                            // if (_formkey.currentState!.validate()) {
                            //   print('form submiitted');
                            // }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: Theme.of(context).primaryColor,
                          child: !authController.isLoading
                              ? textWidget(
                                  text: 'Sign Up',
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 16)
                              : Center(
                                  child: Lottie.asset(
                                      'assets/ui_elementsbgon/animation_lmeiawsk.json')),
                        ),
                      ),
                    )),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Center(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRouts.signInPage);
                          },
                          child: textWidget(
                              maxline: 2,
                              text:
                                  'Alredy have an account ?\n      Click here to login.',
                              color: Theme.of(context).indicatorColor),
                        )),
                      ),
                    ),
                    // Center(
                    //   child: Container(
                    //     padding: EdgeInsets.only(top: 50.h),
                    //     child: Text(
                    //       'SIGN IN',
                    //       style: TextStyle(
                    //           fontSize: 20, fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // )
                  ],
                )),
          ),
        );
      },
    ));
  }
}
