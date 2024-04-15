import 'package:flutter/material.dart';

class BrandingLogo extends StatelessWidget {
  const BrandingLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
