// OutlinedButton that ask for confirmation before deleting the database.

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database.dart';

class ResetSettings extends ConsumerWidget {
  const ResetSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.deleteDb),
              content: Text(AppLocalizations.of(context)!.deleteDbConfirmation),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                FilledButton(
                  onPressed: () {
                    resetDatabase(ref);
                    // Show confirmation snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.dbDeleted),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.delete),
                ),
              ],
            );
          },
        );
      },
      child: Text(AppLocalizations.of(context)!.deleteDb,
          style: const TextStyle(color: Colors.red)),
    );
  }
}
