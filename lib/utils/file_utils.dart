
import 'dart:io';

String get homeDir => 'C:\\Users\\josip\\Documents\\Quick access';

String itemsFilePath() {
  return '$homeDir\\items.json';
}

File? iconFile(String iconName) {
  return File('$homeDir\\icons\\$iconName');
}
