import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/pages/loginScreen.dart';
import 'package:faulkner_county_museum_tour/theme.dart';

/// First screen: museum header, a short history, how the tour works,
/// visit info, and buttons to start as a guest or sign in as a moderator.
/// Text comes from the museum's website and the docent guide slide deck.
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key, required this.onGuestPressed});

  /// Runs when the guest button is tapped.
  /// NavBar uses this to switch to the Keypad tab.
  final VoidCallback onGuestPressed;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Header(),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _InfoCard(
                        icon: Icons.account_balance_outlined,
                        title: 'About the Museum',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Housed in the historic 1896 Faulkner County Jail '
                              'on the Old Courthouse Square in downtown Conway, '
                              'the Faulkner County Museum was founded in 1992 '
                              'and opened to the public in 1997.',
                              style: text.bodyMedium,
                            ),
                            const SizedBox(height: 14),
                            // Mission statement from the docent guide.
                            Container(
                              padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
                              decoration: const BoxDecoration(
                                color: MuseumColors.linen,
                                border: Border(
                                  left: BorderSide(
                                    color: MuseumColors.maroon,
                                    width: 4,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Our mission is to educate the public regarding '
                                'the natural and cultural prehistory and '
                                'history of the geographic region which today '
                                'is known as Faulkner County.',
                                style: text.bodyMedium?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _InfoCard(
                        icon: Icons.help_outline,
                        title: 'How the Tour Works',
                        child: Column(
                          children: [
                            _StepRow(
                              number: '1',
                              icon: Icons.dialpad,
                              text: 'Type the number on an exhibit sign to '
                                  'jump straight to that artifact.',
                            ),
                            _StepRow(
                              number: '2',
                              icon: Icons.meeting_room_outlined,
                              text: 'Or browse the museum room by room, '
                                  'from the front of the museum to the back.',
                            ),
                            _StepRow(
                              number: '3',
                              icon: Icons.arrow_forward,
                              text: 'Read about each artifact and tap Next '
                                  'to follow the tour.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _InfoCard(
                        icon: Icons.place_outlined,
                        title: 'Visit Us',
                        child: Column(
                          children: [
                            _ContactRow(
                              icon: Icons.location_on_outlined,
                              text: '801 Locust St, Conway, AR 72034',
                            ),
                            // TODO: add hours once the museum confirms them.
                            _ContactRow(
                              icon: Icons.schedule,
                              text: 'Hours: TBD',
                            ),
                            _ContactRow(
                              icon: Icons.phone_outlined,
                              text: '501-329-5918',
                            ),
                            _ContactRow(
                              icon: Icons.email_outlined,
                              text: 'fcm@conwaycorp.net',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        key: const Key('intro_guest'),
                        style: FilledButton.styleFrom(
                          backgroundColor: MuseumColors.green,
                          minimumSize: const Size.fromHeight(60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: onGuestPressed,
                        icon: const Icon(Icons.explore_outlined, size: 26),
                        label: const Text('Start the Tour as a Guest'),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        key: const Key('intro_moderator'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: MuseumColors.maroon,
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: MuseumColors.maroon,
                            width: 1.5,
                          ),
                          minimumSize: const Size.fromHeight(60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        ),
                        icon: const Icon(
                          Icons.admin_panel_settings_outlined,
                          size: 26,
                        ),
                        label: const Text('Moderator Sign In'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Maroon band across the top, like the header on the Historical Society
/// website, with a key icon (a nod to the museum) and its motto.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      color: MuseumColors.maroon,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.of(context).padding.top + 32,
        24,
        32,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.vpn_key_outlined,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Faulkner County Museum',
            textAlign: TextAlign.center,
            style: text.headlineSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 6),
          // Motto from the museum.
          Text(
            'Where the past is the key to the future',
            textAlign: TextAlign.center,
            style: text.titleSmall?.copyWith(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'SELF-GUIDED TOUR',
            textAlign: TextAlign.center,
            style: text.labelLarge?.copyWith(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Card with an icon and title, used for each section.
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: MuseumColors.maroon),
                const SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// One numbered step in the "How the Tour Works" card.
class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.number,
    required this.icon,
    required this.text,
  });

  final String number;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: MuseumColors.green,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, size: 22, color: MuseumColors.green),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

/// One line of the "Visit Us" card: an icon and a short line of text.
class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: MuseumColors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}