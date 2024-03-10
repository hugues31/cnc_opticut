import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cnc_opticut/src/database.dart'; // Ensure these imports are correct
import 'package:cnc_opticut/src/material/materials_preset_list.dart';
import 'material_item.dart';

final newMaterialProvider =
    StateNotifierProvider<MaterialNotifier, MaterialItem>(
  (ref) {
    final initialMaterial = softWood;
    initialMaterial.isPreset = false;
    initialMaterial.nameKey = 'Custom Material';
    return MaterialNotifier(initialMaterial);
  },
);

final materialKeysProvider = FutureProvider<List<String>>((ref) async {
  return getMaterialNameKeys(ref);
});

final formValidationProvider = StateProvider<bool>((ref) => false);

class MaterialNotifier extends StateNotifier<MaterialItem> {
  MaterialNotifier(super.state);

  void update(
      {String? nameKey,
      String? imagePath,
      bool? isPreset,
      MaterialSpecs? materialSpecs}) {
    state = MaterialItem(
      nameKey: nameKey ?? state.nameKey,
      imagePath: imagePath ?? state.imagePath,
      isPreset: isPreset ?? state.isPreset,
      materialSpecs: materialSpecs ?? state.materialSpecs,
    );
  }
}

class MaterialAdd extends ConsumerWidget {
  const MaterialAdd({super.key});
  static const routeName = '/add_material';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Material'),
        actions: [
          Consumer(builder: (context, ref, child) {
            final isFormValid = ref.watch(formValidationProvider);
            return IconButton(
              icon: const Icon(Icons.save),
              onPressed: isFormValid
                  ? () {
                      if (formKey.currentState!.validate()) {
                        addMaterialToDatabase(
                            ref, ref.read(newMaterialProvider));
                        ref.invalidate(formValidationProvider);
                        Navigator.pop(context);
                      }
                    }
                  : null,
            );
          }),
        ],
      ),
      body: Center(
        child: ref.watch(materialKeysProvider).when(
              data: (keys) => Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Material Name',
                      ),
                      initialValue: ref.read(newMaterialProvider).nameKey,
                      onChanged: (value) {
                        ref
                            .read(newMaterialProvider.notifier)
                            .update(nameKey: value);
                        // Trigger form validation on change
                        ref.read(formValidationProvider.notifier).state =
                            formKey.currentState?.validate() ?? false;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a name';
                        }
                        if (keys.contains(value)) {
                          return 'Name already exists';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
      ),
    );
  }
}
