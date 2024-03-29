import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podium/src/login/login.dart';

void main() {
  testWidgets('SocialSignInButton renders correctly',
      (WidgetTester tester) async {
    const buttonText = 'Sign in with Google';
    const iconName = 'google-icon.svg';
    void onPressedMock() {}

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SocialSignInButton(
            buttonText: buttonText,
            iconName: iconName,
            onPressed: onPressedMock,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );

    // Verify that the button's text and icon are displayed correctly.
    expect(find.text(buttonText), findsOneWidget);
  });
}
