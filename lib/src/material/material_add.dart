// Widget to create a custom material

import 'package:cnc_opticut/src/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'material_item.dart';

class MaterialAdd extends ConsumerWidget {
  const MaterialAdd({
    super.key,
  });

  static const routeName = '/add_material';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Material'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                MaterialSpecs softWoodSpecs = MaterialSpecs()
                  ..cutSpeedHss = 999 // Example value
                  ..cutSpeedCarbide = 888 // Example value
                  ..depth = [1, 2, 3, 4, 5, 6] // Example values
                  ..chipLoad = [
                    0.01,
                    0.03,
                    0.05,
                    0.09,
                    0.13,
                    0.18
                  ] // Example values
                  ..depthPerPass = [0.3, 1, 2, 3, 4.1, 5.8]; // Example values
                MaterialItem softWood = MaterialItem()
                  ..nameKey = 'custom user material'
                  ..materialSpecs = softWoodSpecs
                  ..imagePath = 'assets/images/particle_board_wood.png'
                  ..isPreset = false;

                addMaterialToDatabase(ref, softWood);
                Navigator.pop(context);
              },
              child: const Text('Add Material'),
            ),
          ],
        ),
      ),
    );
  }
}
