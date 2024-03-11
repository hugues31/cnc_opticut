class Machine {
  String nameKey;
  double rigidity;
  int maxSpindleRotationSpeedRpm;
  int maxAxisFeedSpeedMmPerMin;
  String imagePath;
  bool isPreset;

  Machine({
    required this.nameKey,
    required this.rigidity,
    required this.maxSpindleRotationSpeedRpm,
    required this.maxAxisFeedSpeedMmPerMin,
    required this.imagePath,
    required this.isPreset,
  });
}
