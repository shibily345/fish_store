import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPress;
  const SimpleButton({
    super.key,
    required this.onPress,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor, // Background color
        foregroundColor: Theme.of(context).splashColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)), // Text color
      ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //primery: Theme.of(context).splashColor,
      child: textWidget(
          text: label, color: Theme.of(context).primaryColorDark, fontSize: 16),
    );
  }
}

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomMaterialButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.blue, // Change the button color here
      textColor: Colors.white, // Change the text color here
      child: Text(text),
    );
  }
}
