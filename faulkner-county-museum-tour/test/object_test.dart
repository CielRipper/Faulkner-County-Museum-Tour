import 'package:flutter/material.dart';
import 'package:flutter_application_1/storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Dumping test data adds values correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    Storage.data.dumpTestData();

    expect(Storage.data.artifacts.length == 6, true);
  });
}
