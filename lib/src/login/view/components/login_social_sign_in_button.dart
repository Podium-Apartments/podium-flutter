import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:podium/src/shared/shared_index.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.iconName,
    required this.height,
    required this.width,
  });
  final String buttonText;
  final String iconName;
  final VoidCallback onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.675,
      width: MediaQuery.of(context).size.width,
      child: PlatformElevatedButton(
        color: Colors.white,
        material: (_, __) => MaterialElevatedButtonData(
          style: const ButtonStyle(
            shadowColor: MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            side: MaterialStatePropertyAll(
              BorderSide(),
            ),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
          child: Row(
            children: [
              SvgPicture.asset(
                'lib/src/assets/images/$iconName',
                height: height,
                width: width,
              ),
              Expanded(
                child: SizedBox(
                  width: isMobile(context)
                      ? MediaQuery.of(context).size.width * .75
                      : 430,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.black,
                          letterSpacing: .55,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
