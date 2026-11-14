import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/theme.dart';

// TODO(Jack): Firebase Auth sign-in for moderators goes here.
// The intro screen's "Moderator Sign In" button already opens this screen.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderator Sign In')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Moderator sign-in is coming soon.',
            textAlign: TextAlign.center,
            style: TextStyle(color: MuseumColors.muted),
          ),
        ),
      ),
    );
  }
}