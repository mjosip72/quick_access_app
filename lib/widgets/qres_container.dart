
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/models/qres.dart';
import 'package:quick_access/widgets/qres.dart';
import 'package:quick_access/widgets/qres_editor.dart';
import 'package:reorderables/reorderables.dart';

class QResourcesWidget extends StatelessWidget {
  
  static const double horizontalSpacing = 20;
  static const double verticalSpacing = 20;
  static const double hResourcesPadding = 20;
  static const double vResourcesPadding = 40;

  final List<QResource> items;
  const QResourcesWidget(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return SizedBox(
        width: cons.maxWidth,
        height: cons.maxHeight,
        child: GetBuilder<MainAppController>(
          builder: (context) {
            return ReorderableWrap(
              needsLongPressDraggable: true,
              padding: const EdgeInsets.symmetric(vertical: vResourcesPadding, horizontal: hResourcesPadding),
              onReorder: (oldIndex, newIndex) {
                Get.find<MainAppController>().reorder(items, oldIndex, newIndex);
              },
              spacing: horizontalSpacing,
              runSpacing: verticalSpacing,
              children: items.map(_qres2widget).toList(),
            );
          }
        ),
      );
    });
  }

  Widget _qres2widget(QResource qres) => QResourceWidget(qres);

}

void openChildren(QResource qres) {

  if(!qres.hasChildren) return;

  double containerWidth = 4 * QResourceWidget.width + 3 * QResourcesWidget.horizontalSpacing + 2 * QResourcesWidget.hResourcesPadding;
  double containerHeight = math.min((qres.children.length / 4).ceil(), 2) * QResourceWidget.height + 1 * QResourcesWidget.verticalSpacing + 2 * QResourcesWidget.vResourcesPadding;

  Get.dialog(
    AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Container(
          width: containerWidth,
          height: containerHeight,
          color: Colors.white,
          child: QResourcesWidget(qres.children),
        ),
      ),

    ),
    transitionDuration: 100.milliseconds,
    barrierColor: Colors.black.withOpacity(0.2),
    barrierDismissible: true,
  );

}

void openQResourceEditor({QResource? qres, required QResourceEditorMode mode}) {
  Get.dialog(
    QResourceEditorDialog(qres: qres, mode: mode),
    transitionDuration: 100.milliseconds,
    barrierColor: Colors.black.withOpacity(0.2),
    barrierDismissible: true,
  );
}
