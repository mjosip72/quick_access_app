
import 'dart:convert';
import 'dart:io';

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

  void _loadItems() {
    String source = File(fileUtils.getResourceFilePath()).readAsStringSync();
    List<dynamic> list = jsonDecode(source);
    items.addAll(list.map((e) => QResource.fromMap(e)).toList());
  }

}
