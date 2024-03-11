import 'package:cnc_opticut/src/material/material_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'material_item.dart';

// Define a model for sort state
class SortState {
  final int sortColumnIndex;
  final bool isAscending;

  SortState({required this.sortColumnIndex, required this.isAscending});
}

// Define a provider for managing sort state
final sortProvider = StateProvider<SortState>((ref) {
  return SortState(sortColumnIndex: 0, isAscending: true); // Default sort state
});

class MaterialDetailTable extends ConsumerWidget {
  const MaterialDetailTable({super.key, required this.item});

  final MaterialItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeProvider);
    final sortState = ref.watch(sortProvider);

    // Function to toggle sort state
    void sortData(int columnIndex, bool ascending) {
      // This method should sort your data and then refresh your UI
      // The sorting logic will depend on the specifics of your data
      // Below is a placeholder logic
      // Example for columnIndex 0:
      if (columnIndex == 0) {
        if (ascending) {
          item.materialCuttingChart.sort((a, b) => a.depth.compareTo(b.depth));
        } else {
          item.materialCuttingChart.sort((a, b) => b.depth.compareTo(a.depth));
        }
      }

      // After sorting, update the UI by setting the new state
      ref.read(sortProvider.notifier).state =
          SortState(sortColumnIndex: columnIndex, isAscending: ascending);
    }

    void onSort(int columnIndex, bool ascending) {
      // Call your sorting function
      sortData(columnIndex, ascending);
    }

    return DataTable(
        sortColumnIndex: sortState.sortColumnIndex,
        sortAscending: sortState.isAscending,
        columnSpacing: 0,
        columns: <DataColumn>[
          DataColumn(
            label: Row(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'D',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              // Add info button
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("D (mm)"),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(AppLocalizations.of(context)!.dInfo),
                          const Divider(),
                          Text('${AppLocalizations.of(context)!.unit}: mm'),
                        ]),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.ok),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ]),
            numeric: true,
            onSort: onSort,
          ),
          DataColumn(
            label: Row(children: [
              const Text(
                'Fz',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              // Add info button
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Fz (mm)"),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(AppLocalizations.of(context)!.fzInfo),
                          const Divider(),
                          Text(
                              '${AppLocalizations.of(context)!.unit}: mm/${AppLocalizations.of(context)!.teeth}'),
                          const Divider(),
                          Text('${AppLocalizations.of(context)!.formula}:'),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Math.tex(r'Fz = Vf / (Z * N)',
                                  textStyle: const TextStyle(fontSize: 20))),
                        ]),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.ok),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ]),
            numeric: true,
            onSort: onSort,
          ),
          DataColumn(
            label: Row(children: [
              const Text(
                'Ap',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              // Add info button
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Ap (mm)"),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(AppLocalizations.of(context)!.apInfo),
                          const Divider(),
                          Text('${AppLocalizations.of(context)!.unit}: mm'),
                          const Divider(),
                          Text('${AppLocalizations.of(context)!.formula}:'),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Math.tex(r'Ap = K * D',
                                  textStyle: const TextStyle(fontSize: 20))),
                        ]),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.ok),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ]),
            numeric: true,
            onSort: onSort,
          ),
        ],
        rows: List<DataRow>.generate(
          item.materialCuttingChart.length,
          (int index) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              if (index.isEven) {
                return Colors.grey.withOpacity(0.2);
              }
              return null; // Use default value for other states and odd rows.
            }),
            cells: isEditMode
                ? <DataCell>[
                    DataCell(
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: item.materialCuttingChart[index].depth
                                .toString()),
                        onChanged: (value) {
                          // Check if the value is a valid number
                          if (int.tryParse(value) == null) {
                            return;
                          }
                          item.materialCuttingChart[index].depth =
                              double.parse(value);
                        },
                        onSubmitted: (value) {
                          // Check if the value is a valid number
                          if (int.tryParse(value) == null) {
                            return;
                          }
                          item.materialCuttingChart[index].depth =
                              double.parse(value);
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: item.materialCuttingChart[index].chipLoad
                                .toString()),
                        onChanged: (value) {
                          // Check if the value is a valid number
                          if (double.tryParse(value) == null) {
                            return;
                          }
                          item.materialCuttingChart[index].chipLoad =
                              double.parse(value);
                        },
                        onSubmitted: (value) {
                          // Check if the value is a valid number
                          if (double.tryParse(value) == null) {
                            return;
                          }
                          item.materialCuttingChart[index].chipLoad =
                              double.parse(value);
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: item.materialCuttingChart[index].depthPerPass
                                .toString()),
                        onChanged: (value) {
                          // Check if the value is a valid number
                          if (double.tryParse(value) == null) {
                            return;
                          }
                          item.materialCuttingChart[index].depthPerPass =
                              double.parse(value);
                        },
                        onSubmitted: (value) {
                          // Check if the value is a valid number
                          if (double.tryParse(value) == null) {
                            return;
                          }
                          item.materialCuttingChart[index].depthPerPass =
                              double.parse(value);
                        },
                      ),
                    ),
                  ]
                : <DataCell>[
                    DataCell(
                      Text('${item.materialCuttingChart[index].depth}'),
                    ),
                    DataCell(
                        Text('${item.materialCuttingChart[index].chipLoad}')),
                    DataCell(Text(
                        '${item.materialCuttingChart[index].depthPerPass}')),
                  ],
          ),
        ));
  }
}
