
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:quick_access/widgets/item_editor.dart';


import 'package:get/get.dart';
import 'package:quick_access/models/item.dart';
import 'package:quick_access/widgets/item.dart';

import 'dart:math' as math;

import 'item_container.dart';

void openChildren(Item item) {

  if(!item.hasChildren) return;

  double containerWidth = 4 * ItemWidget.width + 3 * ItemContainerWidget.horizontalSpacing + 2 * ItemContainerWidget.hResourcesPadding;

  int rows = math.min((item.children.length / 4).ceil(), 4);
  double containerHeight = rows * ItemWidget.height + (rows - 1) * ItemContainerWidget.verticalSpacing + 2 * ItemContainerWidget.vResourcesPadding;

  _openDialog(
    content: SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: ContextMenuOverlay(child: ItemContainerWidget(item.children)),
    ),
    backgroundColor: const Color(0xFF303030),
  );

}

void openItemEditor({required Item item, required ItemEditorMode mode}) {
  _openDialog(
    content: ItemEditorWidget(
      item: item,
      mode: mode,
    ),
    backgroundColor: const Color(0xFF303030),
  );
}

void _openDialog({required Widget content, required Color backgroundColor}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: backgroundColor,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      content: content,
    ),
    transitionDuration: 60.milliseconds,
    barrierColor: Colors.black.withOpacity(0.2),
    barrierDismissible: true,
  );
}
