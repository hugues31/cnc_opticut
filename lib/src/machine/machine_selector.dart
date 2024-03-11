// A custom widget for material selection
import 'package:flutter/material.dart';

import '../material/material_item.dart';

class MachineSelectionWidget extends StatelessWidget {
  final MaterialItem selectedMaterial;
  final Function(MaterialItem) onMaterialSelected;

  const MachineSelectionWidget({
    super.key,
    required this.selectedMaterial,
    required this.onMaterialSelected,
  });

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0),
    );
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: radius, // Adjust the radius to match your design
      ),
      child: InkWell(
        borderRadius: radius, // Make sure this matches the Card's borderRadius
        onTap: () async {
          // Handle tap
        },
        onLongPress: () async {
          // Handle long press
        },
        child: Ink(
          child: const ListTile(
            title: Text('Machine Selection'),
            subtitle: Text('Select a machine'),
            trailing: Icon(Icons.arrow_forward),
            leading: Icon(Icons.settings, size: 40),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
