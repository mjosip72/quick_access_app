

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/models/qres.dart';

import 'package:quick_access/utils/file_utils.dart' as fileUtils;
import 'package:quick_access/widgets/qres_container.dart';

class QResourceWidget extends StatefulWidget {

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

        child: ScaleTransition(
          scale: animation,
          child: _QResourceWidgetChild(widget.qres),
        ),
      ),
    );
  }

}

class _QResourceWidgetChild extends StatelessWidget {

  final QResource qres;
  const _QResourceWidgetChild(this.qres, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(File(fileUtils.getIconFilePath(qres.image)), width: 64, height: 64, isAntiAlias: true, filterQuality: FilterQuality.high),
          const SizedBox(height: 8),
          Text(qres.name, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

}

