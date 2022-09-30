
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class TextEditingControllers {

  final _controllers = <String, TextEditingController>{};

  TextEditingControllers.fromList(List<String> keys) {
    for(var key in keys) _controllers[key] = TextEditingController();
  }

  TextEditingControllers.fromMap(Map<String, String> data) {
    data.forEach((key, value) => _controllers[key] = TextEditingController(text: value));
  }

  TextEditingController operator[](String key) {
    return _controllers[key]!;
  }

  void dispose() {
    _controllers.forEach((key, value) => value.dispose());
  }

}
