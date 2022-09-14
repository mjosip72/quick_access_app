import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/models/qres.dart';
import 'package:quick_access/utils/tec.dart';
import 'package:quick_access/widgets/qres_container.dart';

enum QResourceEditorMode {
  addItem,
  editItem,
  addChild,
}

class QResourceEditorDialog extends StatefulWidget {

  final QResource? qres;
  final QResourceEditorMode mode;
  const QResourceEditorDialog({Key? key, required this.mode, this.qres}) : super(key: key);

  @override
  State<QResourceEditorDialog> createState() => _QResourceEditorDialogState();

}

class _QResourceEditorDialogState extends State<QResourceEditorDialog> {

  var teControllers = TextEditingControllers.from(['name', 'icon', 'app', 'args', 'dir']);

  @override
  Widget build(BuildContext context) {

    const vSpacing = SizedBox(height: 12);
    
    return AlertDialog(
      title: _buildHeader(),
      actions: [
        if(widget.mode == QResourceEditorMode.editItem) TextButton(
          onPressed: _onRemoveButton,
          child: const Text('Remove', style: TextStyle(color: Colors.red)),
        ),
        if(widget.mode == QResourceEditorMode.editItem) TextButton(
          onPressed: _onAddChildButton,
          child: const Text('Add child', style: TextStyle(color: Colors.purple))
        ),
        TextButton(onPressed: _onDoneButton, child: const Text('Done', style: TextStyle(color: Colors.green))),
        TextButton(onPressed: _onCancelButton, child: const Text('Cancel', style: TextStyle(color: Colors.blue))),
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          _buildTextInput('Name', 'name', widget.qres?.name),
          vSpacing,
          _buildTextInput('Icon name', 'icon', widget.qres?.image),
          vSpacing,
          _buildTextInput('Program', 'app', widget.qres?.program),
          vSpacing,
          _buildTextInput('Launch arguments', 'args', widget.qres?.launchArguments),
          vSpacing,
          _buildTextInput('Working directory', 'dir', widget.qres?.workingDirectory),
        ],
      ),

    );
  }

  void _onRemoveButton() {

    var controller = Get.find<MainAppController>();
    controller.removeItem(widget.qres!);

    Get.back();

  }

  void _onAddChildButton() {
    _onDoneButton();
    openQResourceEditor(qres: widget.qres, mode: QResourceEditorMode.addChild);
  }

  void _onDoneButton() {

    var controller = Get.find<MainAppController>();

    switch(widget.mode) {

      case QResourceEditorMode.addItem:
        QResource newItem = QResource.empty();
        _fillItemData(newItem);
        controller.items.add(newItem);
        break;

      case QResourceEditorMode.editItem:
        _fillItemData(widget.qres!);
        break;

      case QResourceEditorMode.addChild:
        QResource child = QResource.empty();
        _fillItemData(child);
        widget.qres!.children.add(child);
        break;

    }

    controller.markDirty();
    controller.update();

    Get.back();

  }

  void _onCancelButton() => Get.back();

  void _fillItemData(QResource qres) {
    qres.name = teControllers['name'].text.trim();
    qres.image = teControllers['icon'].text.trim();
    qres.program = teControllers['app'].text.trim();
    qres.launchArguments = teControllers['args'].text.trim();
    qres.workingDirectory = teControllers['dir'].text.trim();
  }

  Widget _buildTextInput(String label, String key, String? defaultText) {
    if(widget.mode != QResourceEditorMode.addChild) teControllers[key].text = defaultText ?? '';
    return SizedBox(
      width: 600,
      child: TextField(
        controller: teControllers[key],
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    switch(widget.mode) {
      case QResourceEditorMode.addItem:
        return const Text('Add item');
      case QResourceEditorMode.editItem:
        return const Text('Edit item');
      case QResourceEditorMode.addChild:
        return const Text('Add subitem');
    }
  }

  @override
  void dispose() {
    teControllers.dispose();
    super.dispose();
  }

}
