import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInFieldWidget extends StatelessWidget {
  const SignInFieldWidget(
      {super.key,
      required this.phoneController,
      required this.passwordController});
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).splashColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).indicatorColor),
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Theme.of(context).indicatorColor.withOpacity(0.4)),
                  hintText: 'Enter Your Phone',
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                  errorStyle: const TextStyle(fontSize: 18.0),
                  border: InputBorder.none),
            ),
          ),
          Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).indicatorColor),
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Theme.of(context).indicatorColor.withOpacity(0.4)),
                  hintText: 'Enter Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.grey,
                  ),
                  errorStyle: const TextStyle(fontSize: 18.0),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
