
String get homeDir => 'C:\\Users\\josip\\Documents\\Quick access';

String itemsFilePath() {
  return '$homeDir\\items.json';
}

String iconFilePath(String iconName) {
  return '$homeDir\\icons\\$iconName';
}
