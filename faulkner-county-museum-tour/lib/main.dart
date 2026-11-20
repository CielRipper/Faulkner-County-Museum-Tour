import 'package:faulkner_county_museum_tour/app_state.dart';
import 'package:faulkner_county_museum_tour/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/roomScreen.dart';
import 'storage.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      lazy: false,
      create: (context) {
        final appState = ApplicationState();
        Storage.appState = appState;
        return appState;
      },
      builder: (context, child) => MaterialApp(
        title: 'Faulkner County Museum Tour',
        theme: buildMuseumTheme(),
        home: const RoomScreen(),
      ),
    )
  );
}
