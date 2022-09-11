

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/widgets/appbar.dart';
import 'package:quick_access/widgets/qres_container.dart';

class MainPage extends StatelessWidget {

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      

      endDrawer: Drawer(
        width: 400,
        backgroundColor: Colors.purple,
        child: const Text('Pozdrav'),
      ),

      body: Column(
        children: [
          const CustomAppBar(),
          QResourcesWidget(Get.find<MainAppController>().items),
        ],
      )

    );
  }
}
