class Machine {
  String nameKey;
  MachineSpecs machineSpecs;
  String imagePath;
  bool isPreset;

  Machine({
    required this.nameKey,
    required this.machineSpecs,
    required this.imagePath,
    required this.isPreset,
  });
}

class MachineSpecs {
  double rigidity = 0.5;
}
