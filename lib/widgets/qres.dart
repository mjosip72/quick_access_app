
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/models/qres.dart';

import 'package:quick_access/utils/file_utils.dart' as fileUtils;
import 'package:quick_access/widgets/qres_container.dart';
import 'package:quick_access/widgets/qres_editor.dart';

class QResourceWidget extends StatefulWidget {

  static const double width = 120;
  static const double height = 120;

  final QResource qres;
  const QResourceWidget(this.qres, {Key? key}) : super(key: key);

  @override
  State<QResourceWidget> createState() => _QResourceWidgetState();

}

class _QResourceWidgetState extends State<QResourceWidget> with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: 80.milliseconds  
    );

    animation = Tween<double>(begin: 1, end: 1.4).animate(animationController);

  }

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (e) => animationController.forward(),
      onExit: (e) => animationController.reverse(),
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTap: () => widget.qres.open(),
        onSecondaryTap: () => openChildren(widget.qres),
        onSecondaryLongPress: () => openQResourceEditor(mode: QResourceEditorMode.editItem, qres: widget.qres),

        child: ScaleTransition(
          scale: animation,
          child: _QResourceWidgetChild(widget.qres),
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

class _QResourceWidgetChild extends StatelessWidget {

  final QResource qres;
  const _QResourceWidgetChild(this.qres, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.blue,
      width: QResourceWidget.width,
      height: QResourceWidget.height,
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

    File imageFile = File(fileUtils.getIconFilePath(qres.image));
    if(!imageFile.existsSync()) {
      return Container(
        width: 64,
        height: 64,
        color: Colors.red,
      );
    }

    return Image.file(
      imageFile,
      width: 64,
      height: 64,
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 64,
          height: 64,
          color: Colors.red,
        );
      },
    );
  
  }

  Widget _buildTextWidget() {
    return Text(
      qres.name,
      maxLines: 2,
      softWrap: true,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
      )
    );
  }

}

