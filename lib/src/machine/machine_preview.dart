import 'dart:io';
import 'package:cnc_opticut/src/machine/machine.dart';
import 'package:path/path.dart' as path;
import 'package:cnc_opticut/src/material/material_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';

class MachinePreview extends ConsumerWidget {
  final Machine selectedMachine;

  const MachinePreview({
    super.key,
    required this.selectedMachine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeProvider);

    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 512, maxHeight: 512),
          child: AspectRatio(
              aspectRatio: 1,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(32),
                clipBehavior:
                    Clip.antiAlias, // Add this line to clip the content

                child: InkWell(
                  onTap: isEditMode
                      ? () {
                          pickImage(context, selectedMachine);
                        }
                      : null,
                  child: Ink.image(
                    image: selectedMachine.getImage(),
                    fit: BoxFit.cover,
                    child: Stack(
                      children: [
                        if (isEditMode) ...[
                          Positioned.fill(
                              child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
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
              )),
        ));
  }
}

void pickImage(BuildContext context, Machine machine) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.selectImageSource),
      content: Text(AppLocalizations.of(context)!.selectImageSourceDesc),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.camera),
          onPressed: () async {
            saveImage(ImageSource.camera, machine);
            // Process your image here
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.gallery),
          onPressed: () async {
            saveImage(ImageSource.gallery, machine);
            // Process your image here
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

void saveImage(ImageSource source, Machine machine) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);

  if (image != null) {
    final Directory directory = await getApplicationDocumentsDirectory();
    String fileName = path.basename(image.path);
    String savedPath = path.join(directory.path, fileName);
    await File(image.path).copy(savedPath);

    machine.imagePath = savedPath;
  }
}
