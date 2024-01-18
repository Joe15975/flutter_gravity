import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'my_screen.dart';

ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(
    ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, value, child) {
          return MaterialApp(
              themeMode: isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
              home: const MyScreen()
          );
        },
    )
  );
}
