import 'package:flutter/material.dart';
import 'package:faulkner_county_museum_tour/pages/introScreen.dart';
import 'package:faulkner_county_museum_tour/pages/roomScreen.dart';
import 'package:faulkner_county_museum_tour/pages/keypadScreen.dart';

/// The bar at the bottom of the app that switches between
/// the Info, Rooms, and Keypad screens.
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // Which tab is showing: 0 = Info, 1 = Rooms, 2 = Keypad
  // Starts at 0 so the intro screen is the first thing you see
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Pick the starting screen for the selected tab
    Widget startScreen;
    if (selectedIndex == 0) {
      startScreen = const IntroScreen();
    } else if (selectedIndex == 1) {
      startScreen = const RoomScreen();
    } else {
      startScreen = const KeypadScreen();
    }

    return Scaffold(
      // Each tab gets its own Navigator so screens opened inside it
      // (like a room's artifacts) stay above the nav bar.
      body: Navigator(
        // A different key per tab tells Flutter to start a fresh
        // Navigator when you switch tabs.
        key: ValueKey(selectedIndex),
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => startScreen);
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.info), label: 'Info'),
          NavigationDestination(icon: Icon(Icons.meeting_room), label: 'Rooms'),
          NavigationDestination(icon: Icon(Icons.dialpad), label: 'Keypad'),
        ],
      ),
    );
  }
}
