
import 'package:quick_access/utils/shell32.dart' as shell32;

extension on Map {

  String? getString(String key) {

    dynamic value = this[key];
    if(value == null) return null;
    
    if(value is String) {
      value = value.trim();
      if(value.isEmpty) return null;
      return value;
    }else{
      return null;
    }

  }

}

class QResource {

  final String name;
  final String image;
  final List<QResource>? children;

  final String file;
  final String? params;
  final String? dir; 

  final bool isChild;

  QResource({
    required this.name,
    required this.image,
    this.children,
    required this.file,
    this.params,
    this.dir,
    this.isChild = false,
  });

  bool get hasChildren => children != null && children!.isNotEmpty;

  void open() {
    shell32.shellExecute(
      file: file,
      params: params,
      dir: dir
    );
  }

  @override
  String toString() {
    return name;
  }

  static QResource fromMap(Map<String, dynamic> map, [bool isChild = false]) {

    List<QResource>? children;
    if(map.containsKey('children')) {
      List<dynamic> c = map['children'];
      children = c.map((e) => QResource.fromMap(e, true)).toList();
    }

    return QResource(
      name: map['name'],
      image: map['image'],
      children: children,
      file: map['file'],
      params: map.getString('params'),
      dir: map.getString('dir'),
      isChild: isChild,
    );

  }

}
