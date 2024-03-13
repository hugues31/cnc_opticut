// A custom widget for material selection
import 'package:cnc_opticut/src/icons.dart';
import 'package:cnc_opticut/src/material/current_material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'material_list_view.dart';

class MaterialSelectionWidget extends ConsumerWidget {
  const MaterialSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const padding = 8.0;
    const small = 4.0;
    const large = 24.0;
    const smallRadius = Radius.circular(small);

    const radiusCard = BorderRadius.only(
      topLeft: smallRadius,
      topRight: smallRadius,
      bottomLeft: smallRadius,
      bottomRight: smallRadius,
    );

    var radiusImage = const BorderRadius.only(
      topLeft: smallRadius,
      topRight: smallRadius,
      bottomLeft: smallRadius,
      bottomRight: smallRadius,
    );

    final currentMaterial = ref.watch(currentMaterialProvider);

    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: radiusCard, // Adjust the radius to match your design
      ),
      child: InkWell(
        borderRadius:
            radiusCard, // Make sure this matches the Card's borderRadius
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MaterialListView()));
        },
        onLongPress: () async {
          // Handle long press
        },
        child: Ink(
          padding: const EdgeInsets.all(8), // Add padding if needed
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4.0, right: 18.0),
                child: Icon(CNCOpticutIcons
                    .material), // Assuming this is your leading icon
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(currentMaterial.getLocalizedName(context),
                        overflow: TextOverflow.fade, softWrap: false),
                    Text(currentMaterial.getLocalizedQuickInfo(context)),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: radiusImage,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: Image(image: currentMaterial.getImage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
