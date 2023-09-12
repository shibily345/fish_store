import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/infrastructure/controller/auth_controller.dart';
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
            print(phone + "--------" + password);
            showCustumeSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
            key: _formkey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                bigSpace, bigSpace, bigSpace, bigSpace,
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 150,
                      //decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(40),
                      //border: Border.all(color: Colors.blueGrey)),
                      child:
                          Image.asset('assets/bstore logos/fullLogoWhite.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.0.h, left: 18.w),
                  child: textWidget(
                      text: "Welcome Back",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, bottom: 20),
                  child: textWidget(
                      text: "Sign In to Your Account",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: BlurContainer(
                    width: Get.width,
                    height: 60,
                    child: TextFormField(
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: phoneController,
                      // validator: MultiValidator([
                      //   RequiredValidator(errorText: 'Enter phone address'),
                      //   phoneValidator(
                      //       errorText: 'Please correct phone filled'),
                      // ]),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          labelStyle: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          hintText: 'Enter Your Phone',
                          labelText: 'Enter Your Phone',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: BlurContainer(
                    width: Get.width,
                    height: 60,
                    child: TextFormField(
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      obscureText: true,
                      controller: passwordController,
                      // validator: MultiValidator([
                      //   RequiredValidator(errorText: 'Enter Password'),
                      //   MinLengthValidator(3,
                      //       errorText:
                      //           'Last name should be atleast 3 charater'),
                      // ]),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          labelStyle: TextStyle(
                              color: Theme.of(context).indicatorColor),
                          hintText: 'Enter Password',
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.grey,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: InputBorder.none),
                    ),
                  ),
                ),

                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                    child: GetBuilder<AuthController>(
                      builder: (auth) {
                        return MaterialButton(
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
                          onPressed: () {
                            _login(auth);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    ),

                    width: MediaQuery.of(context).size.width * 0.4,

                    height: 50,
                  ),
                )),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRouts.signUpPage);
                      },
                      child: textWidget(
                          maxline: 2,
                          text:
                              "Don't have an account ?\n   Click here to Create.",
                          color: Theme.of(context).indicatorColor),
                    )),
                  ),
                ),
                // Center(
                //   child: Container(
                //     padding: EdgeInsets.only(top: 60),
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
    ));
  }
}
