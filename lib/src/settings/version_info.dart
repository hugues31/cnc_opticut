import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = PackageInfo.fromPlatform();
    return FutureBuilder<PackageInfo>(
      future: packageInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text(
                "Version: ${snapshot.data!.version}",
                textAlign:
                    TextAlign.center, // This centers the text horizontally.
              ),
              const Text(
                "Hugues Gaillard",
                textAlign:
                    TextAlign.center, // This centers the text horizontally.
              ),
              Text(
                "© ${DateTime.now().year}",
                textAlign:
                    TextAlign.center, // This centers the text horizontally.
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
