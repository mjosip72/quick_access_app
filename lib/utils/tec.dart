
import 'package:flutter/material.dart';

class TextEditingControllers {

  final _controllers = <String, TextEditingController>{};

  TextEditingControllers.from(List<String> keys) {
    // ignore: curly_braces_in_flow_control_structures
    for(var key in keys) _controllers[key] = TextEditingController();
  }

  TextEditingController operator[](String key) {
    return _controllers[key]!;
  }

  void dispose() {
    _controllers.forEach((key, value) => value.dispose());
  }

}
