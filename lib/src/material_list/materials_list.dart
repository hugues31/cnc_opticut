import 'package:flutter/material.dart';

import 'material_item.dart';

const materialsList = [
  MaterialItem(
      1,
      'Bois tendre / Mdf',
      250,
      500,
      {
        1: [0.01, 0.3],
        2: [0.04, 1],
        3: [0.08, 2],
        4: [0.13, 3],
        5: [0.2, 4.1],
        6: [0.3, 5.8]
      },
      AssetImage('assets/images/particle_board_wood.png')),
  MaterialItem(
      2,
      'Bois dur / CTP',
      250,
      500,
      {
        1: [0.01, 0.25],
        2: [0.03, 0.7],
        3: [0.05, 1.5],
        4: [0.9, 2.5],
        5: [0.13, 3.7],
        6: [0.18, 5.5],
      },
      AssetImage('assets/images/wood.png')),
  MaterialItem(
      3,
      'PVC',
      175,
      350,
      {
        1: [0.01, 0.3],
        2: [0.05, 1.2],
        3: [0.11, 2.3],
        4: [0.2, 3.5],
        5: [0.3, 4.8],
        6: [0.4, 6],
      },
      AssetImage('assets/images/pvc.png')),
  MaterialItem(
      4,
      'POM/PMMA/PC',
      130,
      260,
      {
        1: [0.01, 0.2],
        2: [0.022, 0.6],
        3: [0.035, 1.2],
        4: [0.5, 2],
        5: [0.07, 3.2],
        6: [0.1, 4.8],
      },
      AssetImage('assets/images/pmma.png')),
  MaterialItem(
      5,
      'Brass',
      75,
      150,
      {
        1: [0.005, 0.1],
        2: [0.015, 0.35],
        3: [0.025, 0.65],
        4: [0.038, 0.9],
        5: [0.05, 1.2],
        6: [0.07, 1.5],
      },
      AssetImage('assets/images/brass.png')),
  MaterialItem(
      6,
      'Aluminium+Lub, Si <10%',
      50,
      150,
      {
        1: [0.005, 0.05],
        2: [0.015, 0.3],
        3: [0.025, 0.6],
        4: [0.035, 0.9],
        5: [0.045, 1.2],
        6: [0.06, 1.5],
      },
      AssetImage('assets/images/aluminium.png')),
  MaterialItem(
      7,
      'Alpax+Lub, Si >10%',
      30,
      100,
      {
        1: [0.001, 0.05],
        2: [0.06, 0.15],
        3: [0.013, 0.3],
        4: [0.02, 0.5],
        5: [0.03, 0.7],
        6: [0.04, 0.9],
      },
      AssetImage('assets/images/aluminium.png')),
];
