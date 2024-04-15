import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpFieldWidget extends StatelessWidget {
  const SignUpFieldWidget(
      {super.key,
      required this.mobileController,
      required this.passwordController,
      required this.nameController,
      required this.emailController,
      required this.confirmPasswordController});
  final TextEditingController nameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).splashColor),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.h),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).indicatorColor),
              controller: nameController,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  hintText: 'User / Store Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).indicatorColor,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.all(5.h),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).indicatorColor),
              controller: mobileController,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  hintText: 'Mobile',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.all(5.h),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).indicatorColor),
              controller: emailController,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).indicatorColor,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.all(5.h),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).indicatorColor),
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  hintText: ' Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.all(5.h),
            child: TextFormField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Theme.of(context).indicatorColor),
              obscureText: true,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
