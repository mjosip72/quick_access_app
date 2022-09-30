
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/models/item.dart';
import 'package:quick_access/widgets/item.dart';
import 'package:reorderables/reorderables.dart';

class ItemContainerWidget extends StatelessWidget {
  
  static const double horizontalSpacing = 20;
  static const double verticalSpacing = 20;
  static const double hResourcesPadding = 20;
  static const double vResourcesPadding = 40;

  final List<Item> items;
  const ItemContainerWidget(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return SizedBox(
        width: cons.maxWidth,
        height: cons.maxHeight,

        child: GetBuilder<MainAppController>(
          builder: (con) {
            return ReorderableWrap(

              padding: const EdgeInsets.symmetric(vertical: vResourcesPadding, horizontal: hResourcesPadding),
              spacing: horizontalSpacing,
              runSpacing: verticalSpacing,
              needsLongPressDraggable: false,

              buildDraggableFeedback: _draggableFeedbackBuilder,
              onReorderStarted: (index) => con.isDragging = true,
              onNoReorder: (index) => con.isDragging = false,
              //onReorderStarted: (index) => print('reoder started'),
              //onNoReorder: (index) => print('no reorder'),

              onReorder: (oldIndex, newIndex) {
                con.isDragging = false;
                MainAppController.instance.reorderItem(items, oldIndex, newIndex);
              },

              children: items.map(_qres2widget).toList(),

            );
          }
        ),
      );
    });
  }

  Widget _qres2widget(Item qres) => ItemWidget(qres);

  Widget _draggableFeedbackBuilder(BuildContext context, BoxConstraints constraints, Widget child) {
    return Transform(
      transform: Matrix4.rotationZ(0),

      child: Material(
        color: Colors.grey.shade800,
        borderRadius: const BorderRadius.all(Radius.circular(12)),

        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.minWidth,
            maxWidth: constraints.maxWidth,
            minHeight: constraints.minHeight,
            maxHeight: constraints.maxHeight + 14,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 14),
            child: child,
          )),
      ),
    );
  }

}
