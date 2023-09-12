import 'package:betta_store/presentation/helps/widgets/spaces.dart';
import 'package:betta_store/presentation/helps/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AnimatedGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.loose,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AnimatedContainer(
                height: 120,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(16.0),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 3,
                  //     blurRadius: 10,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 114, 211, 226),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(100, 160),
                            topRight: Radius.elliptical(100, 160),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      ),
                    ),
                    smallSpace,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        textWidget(
                          text: "Devine Aquatics",
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              size: 14,
                            ),
                            textWidget(
                              text: "    200 - 1800",
                              fontSize: 12,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 12,
                            ),
                            textWidget(
                              text: "   cherumukku ,Malappuram",
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
