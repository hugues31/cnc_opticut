// A custom widget for material selection
import 'package:flutter/material.dart';

import 'material_item.dart';
import 'material_list_view.dart';

class MaterialSelectionWidget extends StatelessWidget {
  final MaterialItem selectedMaterial;
  final Function(MaterialItem) onMaterialSelected;

  const MaterialSelectionWidget({
    super.key,
    required this.selectedMaterial,
    required this.onMaterialSelected,
  });

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(0),
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
          MaterialItem? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MaterialListView()),
          );
          if (result != null) {
            onMaterialSelected(result);
          }
        },
        onLongPress: () async {
          // Handle long press
        },
        child: Ink(
          child: ListTile(
            title: Text(selectedMaterial.getLocalizedName(context),
                overflow: TextOverflow.fade, softWrap: false),
            subtitle: const Text(
                'Quick description of a material in multiple lines.\nn=3, d=2.4, v=1000'),
            leading: const Icon(Icons.mark_as_unread),
            trailing: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(24)),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: Image(image: selectedMaterial.getMaterialImage()),
                )),
            // contentPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
