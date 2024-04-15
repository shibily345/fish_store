import 'package:betta_store/core/routs/rout_helper.dart';
import 'package:betta_store/core/utils/widgets/buttons.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/loading.dart';
import 'package:betta_store/core/utils/widgets/privacy_terms.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:betta_store/features/Pages/domain/controller/auth_controller.dart';
import 'package:betta_store/features/Pages/presentation/auth/widgets/psd_reset_content.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Country? _selectedCountry;
  String? _phoneNumber;
  String? _verificationId;
  final PageController _pageController = PageController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _psdController = TextEditingController();
  final TextEditingController _confirmPsdController = TextEditingController();
  bool _verificationSent = false;
  bool _isLoading = false;
  String? _otp;

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+${_selectedCountry!.phoneCode}${_phoneNumber!}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          _isLoading = false;
        });

        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _isLoading = false;
          _pageController.nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );

          _verificationSent = true;
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  Future<void> _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: _otpController.text,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    setState(() {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeInOut,
      );
      _isLoading = false;
    });
  }

  Future<void> restPsd() async {
    if (_confirmPsdController.text != _psdController.text) {
      showCustumeSnackBar("Password dosenot match enter the same password",
          title: "Not match");
    } else if (_psdController.text.length < 6) {
      showCustumeSnackBar("Minimum 6 letter required",
          title: "6 letters required");
    } else {
      return await Get.find<AuthController>()
          .resetPsd(
        _phoneNumber!,
        _psdController.text,
      )
          .then((value) {
        Get.toNamed(AppRouts.getInPage());
        showCustumeSnackBar("Password Successfully changed",
            title: "Reset Successfull");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 600,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bigSpace,
                          const BrandingLogo(),
                          bigSpace,
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: SizedBox(
                                width: 280.w,
                                height: 100,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        text: "Reset Password",
                                      ),
                                      smallSpace,
                                      textWidget(
                                        text:
                                            "Verify your registered phone number via otp to reset your password",
                                        color: Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.4),
                                        fontSize: 16,
                                        maxline: 2,
                                        fontWeight: FontWeight.w400,
                                      )
                                    ])),
                          ),
                          if (_isLoading)
                            const Center(child: CustomeLoader())
                          else
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: BorderRadius.circular(20)),
                                height: 70,
                                width: Get.width,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 18.0.w),
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          showCountryPicker(
                                            context: context,
                                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                            exclude: <String>['KN', 'MF'],
                                            favorite: <String>['IN'],
                                            //Optional. Shows phone code before the country name.
                                            showPhoneCode: true,
                                            onSelect: (Country country) {
                                              setState(() {
                                                _selectedCountry = country;
                                              });
                                              print(
                                                  'Select country: ${country.displayName}');
                                            },
                                            // Optional. Sets the theme for the country list picker.
                                            countryListTheme:
                                                CountryListThemeData(
                                              backgroundColor:
                                                  Theme.of(context).splashColor,
                                              bottomSheetHeight: 500.h,
                                              // Optional. Sets the border radius for the bottomsheet.
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight: Radius.circular(40.0),
                                              ),
                                              // Optional. Styles the search field.
                                              inputDecoration: InputDecoration(
                                                labelText: 'Search',
                                                hintText:
                                                    'Start typing to search',
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color:
                                                        const Color(0xFF8C98A8)
                                                            .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                              // Optional. Styles the text in the search field
                                              searchTextStyle: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 18,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(_selectedCountry != null
                                            ? '${_selectedCountry!.flagEmoji}+${_selectedCountry!.phoneCode} '
                                            : 'Select Code'),
                                      ),
                                      SizedBox(
                                        width: 200.w,
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .indicatorColor),
                                          onChanged: (value) {
                                            _phoneNumber = value;
                                          },
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .indicatorColor
                                                      .withOpacity(0.4)),
                                              hintText: ':  Enter Your Phone',
                                              errorStyle: const TextStyle(
                                                  fontSize: 18.0),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (_verificationSent)
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'OTP'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _otp = value;
                                },
                              ),
                            ),
                          if (_verificationSent)
                            SizedBox(
                              child: ElevatedButton(
                                onPressed: _otp != null ? _verifyOTP : null,
                                child: const Text('Verify OTP'),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(right: 18.0.w),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SimpleButton(
                                onPress: _verificationSent
                                    ? null
                                    : _sendVerificationCode as VoidCallback,
                                label: 'Send Otp',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bigSpace,
                          const BrandingLogo(),
                          bigSpace,
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: SizedBox(
                                width: 280.w,
                                height: 100,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                        color: Theme.of(context).indicatorColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        text: "Enter otp",
                                      ),
                                      textWidget(
                                        text: "Check your sms",
                                        color: Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.4),
                                        fontSize: 16,
                                        maxline: 2,
                                        fontWeight: FontWeight.w400,
                                      )
                                    ])),
                          ),
                          if (_isLoading)
                            const Center(child: CustomeLoader())
                          else
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: BorderRadius.circular(20)),
                                height: 70,
                                width: Get.width,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 18.0.w),
                                  child: SizedBox(
                                    child: Center(
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .indicatorColor),
                                        controller: _otpController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .indicatorColor
                                                    .withOpacity(0.4)),
                                            hintText: '___ ___ ___ ___ ___ ___',
                                            errorStyle:
                                                const TextStyle(fontSize: 18.0),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(right: 18.0.w),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SimpleButton(
                                onPress: _verifyOTP,
                                label: 'Verify Otp',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            bigSpace,
                            bigSpace,
                            bigSpace,
                            bigSpace,
                            bigSpace,
                            bigSpace,
                            bigSpace,
                            bigSpace,
                            bigSpace,
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                  width: 280.w,
                                  height: 100,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textWidget(
                                          color:
                                              Theme.of(context).indicatorColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          text: "Enter New Password",
                                        ),
                                        textWidget(
                                          text: "Confirm again to verify ",
                                          color: Theme.of(context)
                                              .indicatorColor
                                              .withOpacity(0.4),
                                          fontSize: 16,
                                          maxline: 2,
                                          fontWeight: FontWeight.w400,
                                        )
                                      ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: BorderRadius.circular(20)),
                                height: 70,
                                width: Get.width,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 18.0.w),
                                  child: SizedBox(
                                    child: Center(
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .indicatorColor),
                                        controller: _psdController,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .indicatorColor
                                                    .withOpacity(0.4)),
                                            hintText: 'Enter New password',
                                            errorStyle:
                                                const TextStyle(fontSize: 18.0),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    borderRadius: BorderRadius.circular(20)),
                                height: 70,
                                width: Get.width,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 18.0.w),
                                  child: SizedBox(
                                    child: Center(
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .indicatorColor),
                                        controller: _confirmPsdController,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .indicatorColor
                                                    .withOpacity(0.4)),
                                            hintText: 'Confirm password',
                                            errorStyle:
                                                const TextStyle(fontSize: 18.0),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 18.0.w),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: SimpleButton(
                                  onPress: restPsd,
                                  label: 'Confirm',
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                bigSpace,
                bigSpace,
                const Align(
                    alignment: Alignment.bottomCenter,
                    child: PrivecyLabelWidget())
              ]
                  .animate(interval: 100.ms)
                  .fade()
                  .fadeIn(curve: Curves.easeInOut),
            )),
      ),
    );
  }
}
