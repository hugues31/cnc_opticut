// A custom widget for material selection
import 'package:flutter/material.dart';

import '../material_list/material_item.dart';
import '../material_list/material_list_view.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(AppLocalizations.of(context)!.materialSelection),
        // const SizedBox(width: 12),
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: ElevatedButton(
              onPressed: () async {
                MaterialItem? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MaterialListView()),
                );
                if (result != null) {
                  onMaterialSelected(result);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: Text(selectedMaterial.name,
                          overflow: TextOverflow.fade, softWrap: false)),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      selectedMaterial.imagePath,
                      height: 32,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            )),
      ],
    );
  }
}
