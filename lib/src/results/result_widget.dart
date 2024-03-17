import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultWidget extends ConsumerWidget {
  final String name;
  final int result;
  final String unit;
  final Widget explanation;

  const ResultWidget(
      {super.key,
      required this.name,
      required this.result,
      required this.unit,
      required this.explanation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text("$result $unit"),
        tileColor: Theme.of(context).splashColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        // info icon
        trailing: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(name),
                  content: explanation,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.close),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
