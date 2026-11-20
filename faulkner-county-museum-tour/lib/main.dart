import 'package:faulkner_county_museum_tour/app_state.dart';
import 'package:faulkner_county_museum_tour/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/roomScreen.dart';
import 'storage.dart';
import 'theme.dart';



void main() {
  print("hello!");
  WidgetsFlutterBinding.ensureInitialized();
  
  /// Fake rooms and artifacts from Jack's backend until Firebase is set up.
  runApp(ChangeNotifierProvider(
      lazy: false,
      create: (context) {
        print("step 1");
        final appState = ApplicationState();
        print("step2");
        Storage.appState = appState;
        print("step3");
        Storage.data.dumpTestData();
        print("step4");
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

