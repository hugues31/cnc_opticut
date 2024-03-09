// Widget to create a custom material

import 'package:flutter/material.dart';

class MaterialAdd extends StatelessWidget {
  const MaterialAdd({
    super.key,
  });

  static const routeName = '/add_material';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Material'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                // Navigator.pushNamed(context, '/material_add');
              },
              child: Text('Add Material'),
            ),
          ],
        ),
      ),
    );
  }
}
