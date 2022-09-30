
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/widgets/context_menus.dart';
import 'package:quick_access/widgets/item_container.dart';
import 'package:win_titlebar/win_titlebar.dart';

class MainPage extends StatelessWidget {

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WindowTitlebar(),
      body: ContextMenuOverlay(
        child: _buildContent()
      ),
    );
  }

  Widget _buildContent() {
    return ContextMenuRegion(
        contextMenu: const BackgroundContextMenu(),
        longPress: true,
        child: ItemContainerWidget(MainAppController.instance.items),
      );
  }
  
}
