
import 'dart:io';

import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/models/item.dart';

import 'package:quick_access/utils/file_utils.dart' as fileUtils;
import 'package:quick_access/widgets/context_menus.dart';
import 'package:quick_access/widgets/dialogs.dart';

class ItemWidget extends StatefulWidget {

  static const double width = 120;
  static const double height = 120;

  final Item item;
  const ItemWidget(this.item, {Key? key}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();

}

class _ItemWidgetState extends State<ItemWidget> with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: 60.milliseconds  
    );

    animation = Tween<double>(begin: 1, end: 1.4).animate(animationController);

  }

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (e) {
        if(!MainAppController.instance.isDragging) animationController.forward();
      },
      onExit: (e) {
        if(!MainAppController.instance.isDragging) animationController.reverse();
      },
      cursor: SystemMouseCursors.click,

      child: ContextMenuRegion(
        contextMenu: widget.item.isParent ? ItemContextMenu(item: widget.item) : SubItemContextMenu(item: widget.item),
        longPress: true,

        child: GestureDetector(

          onTap: () {
            widget.item.open();
            bool shift = RawKeyboard.instance.keysPressed.contains(LogicalKeyboardKey.shiftLeft);
            if(!shift) MainAppController.instance.onAppClose();
          },

          onSecondaryTap: () => openChildren(widget.item),

          child: ScaleTransition(
            scale: animation,
            filterQuality: FilterQuality.medium,
            child: _ItemWidgetChild(widget.item),
          ),
        ),
      ),
    );

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

}

class _ItemWidgetChild extends StatelessWidget {

  final Item item;
  const _ItemWidgetChild(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ItemWidget.width,
      height: ItemWidget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageWidget(),
          const SizedBox(height: 8),
          _buildTextWidget(),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {

    File? imageFile = fileUtils.iconFile(item.icon);
    if(imageFile == null) return _buildErrorImage();

    return Image.file(
      imageFile,
      width: 64,
      height: 64,
      isAntiAlias: true,
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
    );
  
  }

  Widget _buildTextWidget() {
    return Text(
      item.name,
      maxLines: 2,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        shadows: [
          for(int i = 0; i < 12; i++)
            const Shadow(color: Colors.black, blurRadius: 1, offset: Offset(0, 0)),
        ]
      )
    );
  }

  Widget _buildErrorImage() {
    return Container(
      width: 64,
      height: 64,
      color: Colors.red,
    );
  }

}
