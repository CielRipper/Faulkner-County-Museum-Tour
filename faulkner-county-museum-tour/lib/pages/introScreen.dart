import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/pages/keypadScreen.dart';
import 'package:faulkner_county_museum_tour/pages/loginScreen.dart';
import 'package:faulkner_county_museum_tour/theme.dart';

/// First screen: explains the app and lets visitors continue as a guest
/// or museum staff sign in as a moderator.
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Nod to the museum's key logo.
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: MuseumColors.maroon,
                      child: Icon(Icons.vpn_key_outlined,
                          color: Colors.white, size: 40),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Faulkner County Museum',
                    textAlign: TextAlign.center,
                    style: text.headlineSmall
                        ?.copyWith(color: MuseumColors.maroon),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Self-Guided Tour',
                    textAlign: TextAlign.center,
                    style: text.titleMedium
                        ?.copyWith(color: MuseumColors.muted),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('How it works', style: text.titleMedium),
                          const SizedBox(height: 12),
                          const _OverviewRow(
                            icon: Icons.dialpad,
                            text: 'Type the number on an exhibit sign to jump '
                                'straight to that artifact.',
                          ),
                          const _OverviewRow(
                            icon: Icons.meeting_room_outlined,
                            text: 'Or browse the museum room by room.',
                          ),
                          const _OverviewRow(
                            icon: Icons.arrow_forward,
                            text: 'Read about each artifact and tap Next to '
                                'follow the tour.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    key: const Key('intro_guest'),
                    style: FilledButton.styleFrom(
                      backgroundColor: MuseumColors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const KeypadScreen()),
                    ),
                    icon: const Icon(Icons.person_outline),
                    label: const Text('Continue as Guest'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    key: const Key('intro_moderator'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MuseumColors.maroon,
                      side: const BorderSide(color: MuseumColors.maroon),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    icon: const Icon(Icons.admin_panel_settings_outlined),
                    label: const Text('Moderator Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One line of the "How it works" card: an icon and a short sentence.
class _OverviewRow extends StatelessWidget {
  const _OverviewRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: MuseumColors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}