
import 'dart:convert';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart' as win;
import 'package:get/get.dart';
import 'package:quick_access/models/item.dart';
import 'package:quick_access/utils/file_utils.dart' as fileUtils;

class MainAppController extends GetxController {

  static MainAppController get instance => Get.find<MainAppController>();

  List<Item> items = [];
  bool isDragging = false;

  @override
  void onInit() {
    super.onInit();
    _loadItems();
  }

  void reorderItem(List<Item> list, int oldIndex, int newIndex) {
    markDirty();
    list.insert(newIndex, list.removeAt(oldIndex));
    update();
  }

  void duplicateItem(Item item) {

    int index = items.indexOf(item);

    if(index != -1) {
      items.insert(index + 1, Item.copy(item));
    }else{
      for(var e in items) {
        index = e.children.indexOf(item);
        if(index != -1) {
          e.children.insert(index + 1, Item.copy(item));
          break;
        }
      }
    }

    markDirty();
    update();

  }

  void removeItem(Item item) {
    
    if(items.contains(item)) {
      items.remove(item);
    }else{
      for(var e in items) {
        if(e.children.contains(item)) {
          e.children.remove(item);
          break;
        }
      }
    }

    markDirty();
    update();

  }

  // #region save & load Json data

  void onAppClose() {
    _beforeClose();
    win.appWindow.close();
  }

  void _beforeClose() {
    
    if(!_isDirty) return;
    
    var jsonList = items.map((e) => e.toJson()).toList();
    JsonEncoder encoder = const JsonEncoder.withIndent('\t');
    String json = encoder.convert(jsonList);
    File(fileUtils.itemsFilePath()).writeAsStringSync(json);
  }

  void _loadItems() {
    String source = File(fileUtils.itemsFilePath()).readAsStringSync();
    List<dynamic> list = jsonDecode(source);
    items.addAll(list.map((e) => Item.fromJson(e, isParent: true)).toList());
  }

  bool _isDirty = false;

  void markDirty() {
    if(!_isDirty) _isDirty = true;
  }

  // #endregion

}
