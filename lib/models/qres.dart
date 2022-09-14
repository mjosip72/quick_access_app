
import 'package:quick_access/utils/shell32.dart' as shell32;

class QResource {

  String name;
  String image;

  String program;
  String launchArguments;
  String workingDirectory;

  List<QResource> children;

  QResource({
    required this.name,
    required this.image,
    required this.program,
    required this.launchArguments,
    required this.workingDirectory,
    required this.children,
  });

  QResource.empty() : name = '', image = '', program = '', launchArguments = '', workingDirectory = '', children = [];

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
      'icon': image,
      'app': program,
      'args': launchArguments,
      'dir': workingDirectory,
      'children': children.map((e) => e.toJson()).toList(),
    };
  }

  static QResource fromJson(Map<String, dynamic> map) {
    return QResource(
      name: map.nonEmptyString('name'),
      image: map.nonEmptyString('icon'),
      program: map.nonEmptyString('app'),
      launchArguments: map.nonEmptyString('args'),
      workingDirectory: map.nonEmptyString('dir'),
      children: _getChildren(map, 'children'),
    );
  }

}

List<QResource> _getChildren(Map<String, dynamic> map, String key) {

  if(!map.containsKey(key)) return [];

  dynamic value = map[key];
  if(value is List) {
    return value.map((e) => QResource.fromJson(e)).toList();
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
