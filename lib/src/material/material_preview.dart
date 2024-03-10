import 'package:cnc_opticut/src/material/material_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cnc_opticut/src/material/material_item.dart';

class MaterialPreview extends ConsumerWidget {
  final MaterialItem item;

  const MaterialPreview({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeProvider);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 512),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(item.imagePath),
                  ),
                  if (isEditMode) ...[
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    )),
                    const Positioned.fill(
                        child: Center(
                      // alignment: Alignment.center,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 64, // Adjust size as needed
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
