import 'package:betta_store/core/utils/widgets/text.dart';

import 'package:betta_store/features/store/domain/controller/user_Info_controller.dart';
import 'package:betta_store/features/store/presentation/breeders/widgets/breeder_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreedersPage extends StatefulWidget {
  const BreedersPage({super.key});

  @override
  State<BreedersPage> createState() => _BreedersPageState();
}

class _BreedersPageState extends State<BreedersPage> {
  @override
  void initState() {
    Get.find<UserInfoController>().getBreedersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textWidget(
            text: "Breeders ",
            fontSize: 17,
            color: Theme.of(context).indicatorColor,
          ),
        ),
        body: const BreederListWidget());
  }
}
