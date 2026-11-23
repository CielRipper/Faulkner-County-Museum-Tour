import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/pages/artifactScreen.dart';
import 'package:faulkner_county_museum_tour/pages/roomScreen.dart';
import 'package:faulkner_county_museum_tour/storage.dart';
import 'package:faulkner_county_museum_tour/theme.dart';
import 'package:faulkner_county_museum_tour/widgets/artifactPopup.dart';

/// Guests type the number on an exhibit sign to jump to that artifact.
/// Numbers come from Jack's reference system (Storage.getArtifactByRef).
class KeypadScreen extends StatefulWidget {
  const KeypadScreen({super.key});

  @override
  State<KeypadScreen> createState() => _KeypadScreenState();
}

class _KeypadScreenState extends State<KeypadScreen> {
  static const int maxDigits = 4;
  String _entered = '';

  void _addDigit(String digit) {
    if (_entered.length >= maxDigits) return;
    setState(() => _entered += digit);
  }

  void _backspace() {
    if (_entered.isEmpty) return;
    setState(() => _entered = _entered.substring(0, _entered.length - 1));
  }

  void _go() {
    if (_entered.isEmpty) return;
    final number = int.parse(_entered);
    final artifact = Storage.data.getArtifactByRef(number);
    setState(() => _entered = '');

    if (artifact == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('No exhibit found with number $number')),
        );
      return;
    }

    final room = Storage.data.rooms[artifact.room];
    if (room == null) return;

    // Open the artifact's room, then its popup on top, so Collin's
    // Next button and room change alert keep working from there.
    final navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(builder: (_) => ArtifactScreen(room: room)),
    );
    showArtifactPopup(navigator.context, artifact);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exhibit Number'),
        actions: [
          IconButton(
            icon: const Icon(Icons.meeting_room_outlined),
            tooltip: 'Browse rooms',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const RoomScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter the number on the exhibit sign',
                    textAlign: TextAlign.center,
                    style: text.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _NumberDisplay(entered: _entered, maxDigits: maxDigits),
                  const SizedBox(height: 24),
                  for (final row in const [
                    ['7', '8', '9'],
                    ['4', '5', '6'],
                    ['1', '2', '3'],
                  ]) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (final digit in row)
                          _KeyButton(
                            key: Key('keypad_$digit'),
                            label: digit,
                            onTap: () => _addDigit(digit),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _KeyButton(
                        key: const Key('keypad_backspace'),
                        icon: Icons.backspace_outlined,
                        onTap: _backspace,
                      ),
                      _KeyButton(
                        key: const Key('keypad_0'),
                        label: '0',
                        onTap: () => _addDigit('0'),
                      ),
                      _KeyButton(
                        key: const Key('keypad_go'),
                        icon: Icons.arrow_forward,
                        onTap: _go,
                        filled: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // TEST ONLY: remove once real exhibit numbers come from the museum.
                  const Text(
                    'Test numbers: 101, 102, 201, 301, 302, 303',
                    style: TextStyle(color: MuseumColors.muted),
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

/// The boxes at the top that show the digits typed so far.
class _NumberDisplay extends StatelessWidget {
  const _NumberDisplay({required this.entered, required this.maxDigits});

  final String entered;
  final int maxDigits;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < maxDigits; i++)
          Container(
            width: 52,
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                // highlight the box the next digit goes into
                color: i == entered.length
                    ? MuseumColors.maroon
                    : MuseumColors.placeholder,
                width: 2,
              ),
            ),
            child: Text(
              i < entered.length ? entered[i] : '',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: MuseumColors.ink,
              ),
            ),
          ),
      ],
    );
  }
}

/// One round key on the keypad: a digit, or an icon for backspace / go.
class _KeyButton extends StatelessWidget {
  const _KeyButton({
    super.key,
    this.label,
    this.icon,
    required this.onTap,
    this.filled = false,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final background = filled ? MuseumColors.green : Colors.white;
    final foreground = filled ? Colors.white : MuseumColors.maroon;

    return SizedBox(
      width: 76,
      height: 76,
      child: Material(
        color: background,
        shape: const CircleBorder(
          side: BorderSide(color: MuseumColors.placeholder, width: 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: icon != null
                ? Icon(icon, color: foreground, size: 28)
                : Text(
                    label ?? '',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: foreground,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}