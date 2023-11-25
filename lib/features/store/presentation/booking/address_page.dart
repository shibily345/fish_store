import 'package:betta_store/features/store/domain/controller/address_Info_controller.dart';
import 'package:betta_store/features/store/domain/models/address_model.dart';
import 'package:betta_store/features/store/presentation/booking/confirm_book.dart';
import 'package:betta_store/core/utils/widgets/containers.dart';
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _secPhoneController = TextEditingController();
  late bool _isLogged;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _pincodeFocus = FocusNode();
  final FocusNode _phonePrFocus = FocusNode();
  final FocusNode _phoneSrFocus = FocusNode();

  @override
  void dispose() {
    // Dispose of the FocusNodes when they are no longer needed
    _nameFocus.dispose();
    _addressFocus.dispose();
    _pincodeFocus.dispose();
    _phonePrFocus.dispose();
    _phoneSrFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Get.find<AddressInfoController>().getUserAddress();
    // _isLogged = Get.find<AuthController>().userLogedIn();
    // if (_isLogged && Get.find<UserInfoController>().userModel == null) {
    //   Get.find<UserInfoController>().getUserInfo();
    // }
    Get.find<AddressInfoController>().getUserAddress();
    if (Get.find<AddressInfoController>().addressList.isNotEmpty) {
      if (Get.find<AddressInfoController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<AddressInfoController>().saveUserAddress(
            Get.find<AddressInfoController>().addressList.last);
      }
    }
    Get.find<AddressInfoController>().getUserAddress();
    if (Get.find<AddressInfoController>().getUserAddress() != null) {
      _nameController.text =
          Get.find<AddressInfoController>().getUserAddress().name;
      _addressController.text =
          Get.find<AddressInfoController>().getUserAddress().address;
      _pincodeController.text =
          Get.find<AddressInfoController>().getUserAddress().pincode;
      _phoneController.text =
          Get.find<AddressInfoController>().getUserAddress().phone;
      _secPhoneController.text =
          Get.find<AddressInfoController>().getUserAddress().secondoryPhone;
    }
    super.initState();
  }

  _addAddress() {
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    String pincode = _pincodeController.text.trim();
    String phone = _phoneController.text.trim();
    String secPhone = _secPhoneController.text.trim();
    if (name.isEmpty) {
      showCustumeSnackBar("Enter Your Name", title: "Name is Empty");
    } else if (address.isEmpty) {
      showCustumeSnackBar("Enter Your Address", title: "Address is Empty");
    } else if (pincode.isEmpty) {
      showCustumeSnackBar("Enter Your pincode", title: "pincode is Empty");
    } else if (pincode.length < 6) {
      showCustumeSnackBar("Enter minimum 6 letters in pinCode",
          title: "Pincode Not valid");
    } else if (phone.isEmpty) {
      showCustumeSnackBar("Enter Phone No", title: "Phone Not match");
    } else {
      AddressModel fullAddress = AddressModel(
          name: name,
          addressType: 'Home',
          address: address,
          phone: phone,
          pincode: pincode,
          secondoryPhone: secPhone);
      Get.find<AddressInfoController>()
          .addAddress(fullAddress)
          .then((response) {
        if (response.isSuccess) {
          Get.to(() => const ConfirmBook());
          Get.snackbar("Address", "Success");
        } else {
          Get.snackbar(
              "Error Occurred", "Report us immidietly Profil>Contact us");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 18.0.h, left: 10.w),
                  child: textWidget(
                      text: "Add new address",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 100.w, bottom: 20, left: 10.w),
                  child: textWidget(
                      maxline: 2,
                      text:
                          "Make sure your address is accurate to prevent any delivery problems",
                      color: Theme.of(context).indicatorColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: BlurContainer(
                    width: Get.width,
                    height: 50.h,
                    child: TextFormField(
                      focusNode: _nameFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_addressFocus);
                      },
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _nameController,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Full Name',
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
                    height: 100.h,
                    child: TextFormField(
                      focusNode: _addressFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_pincodeFocus);
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _addressController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Full Address',
                          prefixIcon: const Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
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
                      keyboardType: TextInputType.phone,
                      focusNode: _pincodeFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_phonePrFocus);
                      },
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _pincodeController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Pincode',
                          prefixIcon: Icon(
                            Icons.pin_drop_rounded,
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
                      keyboardType: TextInputType.phone,
                      focusNode: _phonePrFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_phoneSrFocus);
                      },
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _phoneController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: ' PhoneNo',
                          prefixIcon: const Icon(
                            Icons.phone_android,
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
                      keyboardType: TextInputType.phone,
                      focusNode: _phoneSrFocus,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {},
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                      controller: _secPhoneController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          hintText: 'Secondory phoneNo',
                          prefixIcon: const Icon(
                            Icons.phone_android,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 0.0.w),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(160, 20, 10, 0),
                    width: 200.w,
                    height: 50.h,
                    child: MaterialButton(
                      onPressed: () {
                        _addAddress();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).primaryColor,
                      child: textWidget(
                          text: 'Proceed to Book',
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 16),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
