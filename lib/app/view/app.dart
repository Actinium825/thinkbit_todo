import 'package:flutter/material.dart';
import 'package:thinkbit_todo/todo/view/todo_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
  }
}
