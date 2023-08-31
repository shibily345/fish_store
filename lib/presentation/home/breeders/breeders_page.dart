import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/material.dart';

class BreedersPage extends StatelessWidget {
  const BreedersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: textWidget(
          text: "Breeders",
        ),
      ),
    );
  }
}
