import 'package:flutter/material.dart';
import 'package:podium/src/shared/shared_index.dart';

class PodiumFooter extends StatelessWidget {
  const PodiumFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Divider(
            thickness: 0,
            color: Colors.grey.shade200,
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PodiumLogoWithTitle(height: 80),
            LinkedInLink(),
            Text('© 2023 Podium Apartments Inc.')
          ],
        ),
      ],
    );
  }
}
