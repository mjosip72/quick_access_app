
class WindowData {
  
  final double x;
  final double y;
  final double width;
  final double height;

  WindowData({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  static WindowData fromJson(Map<String, dynamic> source) {
    return WindowData(
      x: source['x'],
      y: source['y'],
      width: source['width'],
      height: source['height'],
    );
  }

}
