import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final Icon? prefixIcon;
  final VoidCallback? onEditingComplete;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.prefixIcon,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          maxLines: null,
          expands: true,
          style: TextStyle(color: Theme.of(context).indicatorColor),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Theme.of(context).primaryColorLight),
            hintText: hintText,
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
