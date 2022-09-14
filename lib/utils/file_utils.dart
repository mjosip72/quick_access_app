
String get homeDir => 'C:\\Users\\josip\\Documents\\Quick access';

String getResourceFilePath() {
  return '$homeDir\\resources.json';
}

String getIconFilePath(String iconName) {
  return '$homeDir\\icons\\$iconName';
}
