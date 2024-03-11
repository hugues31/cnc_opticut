// A custom widget for material selection
import 'package:flutter/material.dart';

import '../material/material_item.dart';
import '../material/material_list_view.dart';

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
            subtitle: const Text('Quick description of a material'),
            leading: const Icon(Icons.mark_as_unread),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image(image: selectedMaterial.getMaterialImage()),
                    )),
                const Icon(Icons.arrow_forward, size: 40),
              ],
            ),
            // contentPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
