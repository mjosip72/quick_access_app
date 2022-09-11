
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/models/qres.dart';
import 'package:quick_access/widgets/qres.dart';

class QResourcesWidget extends StatelessWidget {
  
  final List<QResource> items;
  const QResourcesWidget(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Wrap(
        spacing: 40,
        runSpacing: 20,
        children: items.map(_qres2widget).toList(),
      )
    );
  }

  Widget _qres2widget(QResource qres) => QResourceWidget(qres);

}

void openChildren(QResource qres) {

  if(!qres.hasChildren) return;

  Get.dialog(
    AlertDialog(
      contentPadding: EdgeInsets.zero,
      
      content: Container(
        width: 4 * 140 + 40 * 3 + 120,
        color: Colors.white,
        child: QResourcesWidget(qres.children!),
      ),

    ),
    transitionDuration: 100.milliseconds,
    barrierColor: Colors.white.withOpacity(0.4),
    barrierDismissible: true,
  );

}