// A custom widget for material selection
import 'package:flutter/material.dart';

import '../material/material_item.dart';

class ToolSelectionWidget extends StatelessWidget {
  final MaterialItem selectedMaterial;
  final Function(MaterialItem) onMaterialSelected;

  const ToolSelectionWidget({
    super.key,
    required this.selectedMaterial,
    required this.onMaterialSelected,
  });

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(4),
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(24),
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
            title: Text('Tool Selection'),
            subtitle: Text('Select a tool'),
            trailing: Icon(Icons.arrow_forward),
            leading: Icon(Icons.tornado, size: 40),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
