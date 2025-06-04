import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thinkbit_todo/app/view/app.dart';
import 'package:thinkbit_todo/bootstrap.dart';

import 'firebase_options_prod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bootstrap(() => const App());
}
