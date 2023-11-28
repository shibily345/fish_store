import 'package:flutter/material.dart';

class BrandingLogo extends StatelessWidget {
  const BrandingLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Theme.of(context).splashColor,
          ),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/bstore logos/labelWithTagWhite.png',
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}





// import 'package:betta_store/core/utils/widgets/buttons.dart';
// import 'package:betta_store/core/utils/widgets/loading.dart';
// import 'package:betta_store/core/utils/widgets/spaces.dart';
// import 'package:betta_store/core/utils/widgets/text.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class EnterPhoneField extends StatefulWidget {
//   EnterPhoneField(
//       {super.key,
//       required this.isloading,
//       required this.selectedCountry,
//       required this.phoneNumber,
//       required this.otp,
//       required this.verificationSent,
//       required this.verifyOTP,
//       required this.sendVerificationCode});
//   bool isloading;
//   VoidCallback verifyOTP;
//   VoidCallback sendVerificationCode;
//   Country selectedCountry;
//   String phoneNumber;
//   bool verificationSent;
//   String otp;
//   @override
//   State<EnterPhoneField> createState() => _EnterPhoneFieldState();
// }

// class _EnterPhoneFieldState extends State<EnterPhoneField> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       //  mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         bigSpace,
//         Container(
//           decoration: BoxDecoration(
//               // color: Theme.of(context).splashColor,
//               ),
//           child: Center(
//             child: SizedBox(
//               width: 200,
//               height: 200,
//               child: Image.asset(
//                 'assets/bstore logos/labelWithTagWhite.png',
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//           ),
//         ),
//         bigSpace,
//         Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SizedBox(
//               width: 280.w,
//               height: 100,
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     textWidget(
//                       color: Theme.of(context).indicatorColor,
//                       fontSize: 25,
//                       fontWeight: FontWeight.w600,
//                       text: "Reset Password",
//                     ),
//                     smallSpace,
//                     textWidget(
//                       text:
//                           "Verify your registered phone number via otp to reset your password",
//                       color: Theme.of(context).indicatorColor.withOpacity(0.4),
//                       fontSize: 16,
//                       maxline: 2,
//                       fontWeight: FontWeight.w400,
//                     )
//                   ])),
//         ),
//         if (widget.isloading)
//           Center(child: CustomeLoader())
//         else
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Theme.of(context).splashColor,
//                   borderRadius: BorderRadius.circular(20)),
//               height: 70,
//               width: Get.width,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 18.0.w),
//                 child: Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         showCountryPicker(
//                           context: context,
//                           //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
//                           exclude: <String>['KN', 'MF'],
//                           favorite: <String>['IN'],
//                           //Optional. Shows phone code before the country name.
//                           showPhoneCode: true,
//                           onSelect: (Country country) {
//                             setState(() {
//                               widget.selectedCountry = country;
//                             });
//                             print('Select country: ${country.displayName}');
//                           },
//                           // Optional. Sets the theme for the country list picker.
//                           countryListTheme: CountryListThemeData(
//                             backgroundColor: Theme.of(context).splashColor,
//                             bottomSheetHeight: 500.h,
//                             // Optional. Sets the border radius for the bottomsheet.
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(40.0),
//                               topRight: Radius.circular(40.0),
//                             ),
//                             // Optional. Styles the search field.
//                             inputDecoration: InputDecoration(
//                               labelText: 'Search',
//                               hintText: 'Start typing to search',
//                               prefixIcon: const Icon(Icons.search),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color:
//                                       const Color(0xFF8C98A8).withOpacity(0.2),
//                                 ),
//                               ),
//                             ),
//                             // Optional. Styles the text in the search field
//                             searchTextStyle: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 18,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Text(widget.selectedCountry != null
//                           ? '${widget.selectedCountry.flagEmoji}+${widget.selectedCountry.phoneCode} '
//                           : 'Select Code'),
//                     ),
//                     SizedBox(
//                       width: 200.w,
//                       child: TextFormField(
//                         style:
//                             TextStyle(color: Theme.of(context).indicatorColor),
//                         onChanged: (value) {
//                           widget.phoneNumber = value;
//                         },
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                             hintStyle: TextStyle(
//                                 color: Theme.of(context)
//                                     .indicatorColor
//                                     .withOpacity(0.4)),
//                             hintText: ':  Enter Your Phone',
//                             errorStyle: const TextStyle(fontSize: 18.0),
//                             border: InputBorder.none),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         if (widget.verificationSent)
//           SizedBox(
//             child: TextFormField(
//               decoration: InputDecoration(labelText: 'OTP'),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 widget.otp = value;
//               },
//             ),
//           ),
//         if (widget.verificationSent)
//           SizedBox(
//             child: ElevatedButton(
//               onPressed: widget.otp != null ? widget.verifyOTP : null,
//               child: Text('Verify OTP'),
//             ),
//           ),
//         Padding(
//           padding: EdgeInsets.only(right: 18.0.w),
//           child: Align(
//             alignment: Alignment.topRight,
//             child: SimpleButton(
//               onPress: widget.verificationSent
//                   ? null
//                   : widget.sendVerificationCode as VoidCallback,
//               label: 'Send Otp',
//             ),
//           ),
//         ),
//         if (widget.isloading) Center(child: CustomeLoader()),
//       ],
//     );
//   }
// }
