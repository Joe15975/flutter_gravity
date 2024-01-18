import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'my_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(
    const MaterialApp(
        home: MyScreen()
    )
  );
}
