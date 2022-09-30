
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/models/item.dart';
import 'package:quick_access/utils/tec.dart';

enum ItemEditorMode {
  addItem,
  editItem,
  addChild,
}

class ItemEditorWidget extends StatefulWidget {

  final Item item;
  final ItemEditorMode mode;
  const ItemEditorWidget({Key? key, required this.item, required this.mode}) : super(key: key);

  @override
  State<ItemEditorWidget> createState() => _ItemEditorWidgetState();

}

class _ItemEditorWidgetState extends State<ItemEditorWidget> {
  
  late var texts = TextEditingControllers.fromList(['name', 'icon', 'app', 'args', 'dir']);

  @override
  void initState() {
    if(widget.mode != ItemEditorMode.addChild) _fillTextControllers(widget.item);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const vSpacing = SizedBox(height: 12);
    return Container(
      padding: const EdgeInsets.all(20),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          
          Align(alignment: Alignment.topLeft, child: _buildHeader()),
          const SizedBox(height: 20),

          _buildTextInput('Name', 'name'),
          vSpacing,
          _buildTextInput('Icon name', 'icon'),
          vSpacing,
          _buildTextInput('Program', 'app'),
          vSpacing,
          _buildTextInput('Launch arguments', 'args'),
          vSpacing,
          _buildTextInput('Working directory', 'dir'),

          const SizedBox(height: 20),
          _buildActionButtons(),

        ],
      ),

    );
  }

  void _onApplyButton() {
    
    var controller = MainAppController.instance;

    switch(widget.mode) {

      case ItemEditorMode.addItem:
        _fillItemData(widget.item);
        controller.items.add(widget.item);
        break;

      case ItemEditorMode.editItem:
        _fillItemData(widget.item);
        break;

      case ItemEditorMode.addChild:
        Item child = Item.empty(isParent: false);
        _fillItemData(child);
        widget.item.children.add(child);
        break;

    }

    controller.markDirty();
    controller.update();
    Get.back();

  }

  void _fillTextControllers(Item item) {
    texts['name'].text = item.name;
    texts['icon'].text = item.icon;
    texts['app'].text = item.program;
    texts['args'].text = item.launchArguments;
    texts['dir'].text = item.workingDirectory;
  }

  void _fillItemData(Item item) {
    item.name = texts['name'].text.trim();
    item.icon = texts['icon'].text.trim();
    item.program = texts['app'].text.trim();
    item.launchArguments = texts['args'].text.trim();
    item.workingDirectory = texts['dir'].text.trim();
  }

  Widget _buildActionButtons() {
    const textStyle = TextStyle(fontSize: 16);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: _onApplyButton,
          child: const Text('Apply', style: textStyle),
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel', style: textStyle),
        ),
      ],
    );
  }

  Widget _buildTextInput(String label, String key) {
    return SizedBox(
      width: 600,
      child: TextField(
        controller: texts[key],
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      _titleText,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  String get _titleText {
    switch(widget.mode) {
      case ItemEditorMode.addItem:
        return 'Add item';
      case ItemEditorMode.editItem:
        return 'Edit item';
      case ItemEditorMode.addChild:
        return 'Add subitem';
    }
  }

  @override
  void dispose() {
    texts.dispose();
    super.dispose();
  }

}
