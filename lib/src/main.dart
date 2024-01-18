
import 'package:flutter/material.dart';

import '../flutter_gravity.dart';
import 'my_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Gravity.ensureInitialized();

  runApp(
    const MaterialApp(
        home: MyScreen()
    )
  );
}
