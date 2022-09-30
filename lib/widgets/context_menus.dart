
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_access/controllers/main_app.dart';
import 'package:quick_access/models/item.dart';
import 'package:quick_access/widgets/dialogs.dart';
import 'package:quick_access/widgets/item_editor.dart';

class BackgroundContextMenu extends StatelessWidget {

  const BackgroundContextMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ContextMenuContainer(
      children: [
        ContextMenuItem(
          text: 'Add item',
          icon: Icons.add,
          onTap: () {
            Get.back();
            openItemEditor(
              item: Item.empty(isParent: true),
              mode: ItemEditorMode.addItem
            );
          },
        ),
        ContextMenuItem(
          text: 'Settings',
          icon: Icons.settings,
          onTap: () {
            // TODO implement
          },
        ),
      ],
    );
  }

}

class ItemContextMenu extends StatelessWidget {

  final Item item;
  const ItemContextMenu({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ContextMenuContainer(
      children: [
        ContextMenuItem(
          text: 'Add subitem',
          icon: Icons.add,
          onTap: () {
            openItemEditor(
              item: item,
              mode: ItemEditorMode.addChild,
            );
          },
        ),
        ContextMenuItem(
          text: 'Edit item',
          icon: Icons.edit,
          onTap: () {
            openItemEditor(
              item: item,
              mode: ItemEditorMode.editItem,
            );
          },
        ),
        ContextMenuItem(
          text: 'Duplicate item',
          icon: Icons.copy,
          onTap: () {
            MainAppController.instance.duplicateItem(item);
          },
        ),
        ContextMenuItem(
          text: 'Delete item',
          icon: Icons.delete,
          onTap: () {
            MainAppController.instance.removeItem(item);
          },
        ),
      ],
    );
  }

}

class SubItemContextMenu extends StatelessWidget {

  final Item item;
  const SubItemContextMenu({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ContextMenuContainer(
      children: [
        ContextMenuItem(
          text: 'Edit item',
          icon: Icons.edit,
          onTap: () {
            openItemEditor(
              item: item,
              mode: ItemEditorMode.editItem,
            );
          },
        ),
        ContextMenuItem(
          text: 'Duplicate item',
          icon: Icons.copy,
          onTap: () {
            MainAppController.instance.duplicateItem(item);
          },
        ),
        ContextMenuItem(
          text: 'Delete item',
          icon: Icons.delete,
          onTap: () {
            MainAppController.instance.removeItem(item);
          },
        ),
      ],
    );
  }

}


class ContextMenuItem extends StatelessWidget {

  final IconData icon;
  final String text;
  final void Function() onTap;
  const ContextMenuItem({Key? key, required this.text, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF303030),
      child: ListTile(
        focusColor: Colors.blue.shade800,
        hoverColor: Colors.blue.shade800,
        selectedColor: Colors.blue.shade800,
        horizontalTitleGap: 0,
        dense: true,
        leading: Icon(icon),
        title: Text(text),
        onTap: () {
          context.contextMenuOverlay.hide();
          onTap();
        },
      ),
    );
  }

}

class _ContextMenuContainer extends StatelessWidget {

  final List<Widget> children;
  const _ContextMenuContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4, spreadRadius: 1.2, offset: const Offset(0, 0)),
        ]
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),

    );
  }

}
