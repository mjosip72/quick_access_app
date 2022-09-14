
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';

import 'package:quick_access/widgets/appbar.dart';
import 'package:quick_access/widgets/qres_container.dart';
import 'package:quick_access/widgets/qres_editor.dart';

class MainPage extends StatelessWidget {

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          QResourcesWidget(Get.find<MainAppController>().items),
          const _AddQResourceButton(),
        ],
      ),
    );
  }
  
}

class _AddQResourceButton extends StatelessWidget {

  const _AddQResourceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: SizedBox.square(
        dimension: 60,
        child: IconButton(
          hoverColor: Colors.blue.shade800,
          splashColor: Colors.blue,
          highlightColor: Colors.blue,
          color: Colors.white,
          onPressed: () => openQResourceEditor(mode: QResourceEditorMode.addItem),
          iconSize: 32,
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
