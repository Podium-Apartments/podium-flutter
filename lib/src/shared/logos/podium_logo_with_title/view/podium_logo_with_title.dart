import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PodiumLogoWithTitle extends StatelessWidget {
  const PodiumLogoWithTitle({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/');
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          'lib/src/assets/images/podium_logo_with_title.png',
        ),
      ),
    );
  }
}
