
import 'dart:convert';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart' as win;
import 'package:get/get.dart';
import 'package:quick_access/models/qres.dart';
import 'package:quick_access/utils/file_utils.dart' as fileUtils;

class MainAppController extends GetxController {

  List<QResource> items = [];

  @override
  void onInit() {
    super.onInit();
    _loadItems();
  }

  void reorder(List<QResource> list, int oldIndex, int newIndex) {
    markDirty();
    list.insert(newIndex, list.removeAt(oldIndex));
    update();
  }

  void removeItem(QResource qres) {
    
    if(items.contains(qres)) {
      items.remove(qres);
    }else{
      for(var e in items) {
        if(e.children.contains(qres)) {
          e.children.remove(qres);
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
    File(fileUtils.getResourceFilePath()).writeAsStringSync(json);
  }

  void _loadItems() {
    String source = File(fileUtils.getResourceFilePath()).readAsStringSync();
    List<dynamic> list = jsonDecode(source);
    items.addAll(list.map((e) => QResource.fromJson(e)).toList());
  }

  bool _isDirty = false;

  void markDirty() {
    if(!_isDirty) _isDirty = true;
  }

  // #endregion

}
