// A custom widget for material selection
import 'package:cnc_opticut/src/icons.dart';
import 'package:cnc_opticut/src/tool/current_tool.dart';
import 'package:cnc_opticut/src/tool/tool_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolSelectionWidget extends ConsumerWidget {
  const ToolSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTool = ref.watch(currentToolProvider);

    const baseRadius = Radius.circular(4);
    const largeRadius = Radius.circular(24);

    const radiusCard = BorderRadius.only(
      topLeft: baseRadius,
      topRight: baseRadius,
      bottomLeft: largeRadius,
      bottomRight: largeRadius,
    );

    const radiusImage = BorderRadius.only(
      topLeft: baseRadius,
      topRight: baseRadius,
      bottomLeft: baseRadius,
      bottomRight: largeRadius,
    );

    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: radiusCard, // Adjust the radius to match your design
      ),
      child: InkWell(
        borderRadius:
            radiusCard, // Make sure this matches the Card's borderRadius
        onTap: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ToolListView()));
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
                    .cutterTool), // Assuming this is your leading icon
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(currentTool.nameKey,
                        overflow: TextOverflow.fade, softWrap: false),
                    Text(currentTool.getLocalizedQuickInfo(context)),
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
                  child: Image(image: currentTool.getImage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
