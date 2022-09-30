
import 'package:quick_access/utils/shell32.dart' as shell32;

class Item {

  String name;
  String icon;

  String program;
  String launchArguments;
  String workingDirectory;

  List<Item> children;
  bool isParent;

  Item({
    required this.name,
    required this.icon,
    required this.program,
    required this.launchArguments,
    required this.workingDirectory,
    required this.children,
    required this.isParent,
  });

  Item.copy(Item item) : 
    name = item.name,
    icon = item.icon,
    program = item.program,
    launchArguments = item.launchArguments,
    workingDirectory = item.workingDirectory,
    children = [],
    isParent = item.isParent;

  Item.empty({required this.isParent}) : 
    name = '',
    icon = '',
    program = '',
    launchArguments = '',
    workingDirectory = '',
    children = [];

  int open() {
    return shell32.shellExecute(
      operation: 'open',
      file: program,
      params: launchArguments,
      dir: workingDirectory,
    );
  }

  bool get hasChildren => children.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'app': program,
      'args': launchArguments,
      'dir': workingDirectory,
      'children': children.map((e) => e.toJson()).toList(),
    };
  }

  static Item fromJson(Map<String, dynamic> map, {required bool isParent}) {
    return Item(
      name: map.nonEmptyString('name'),
      icon: map.nonEmptyString('icon'),
      program: map.nonEmptyString('app'),
      launchArguments: map.nonEmptyString('args'),
      workingDirectory: map.nonEmptyString('dir'),
      children: _getChildren(map, 'children'),
      isParent: isParent,
    );
  }

}

List<Item> _getChildren(Map<String, dynamic> map, String key) {

  if(!map.containsKey(key)) return [];

  dynamic value = map[key];
  if(value is List) {
    return value.map((e) => Item.fromJson(e, isParent: false)).toList();
  }

  return [];

}

extension on Map {

  String nonEmptyString(String key) {
    dynamic value = this[key];
    if(value == null) return '';
    if(value is String) return value.trim();
    return '';
  }

}
