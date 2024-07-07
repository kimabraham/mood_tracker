import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood tracker',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffF5F9FF),
          surfaceTintColor: Color(0xffF5F9FF),
        ),
        scaffoldBackgroundColor: const Color(0xffF5F9FF),
        colorScheme: const ColorScheme.light(
          primary: Color(0xff3D5BA9),
          secondary: Color(0xff79B1F1),
          inversePrimary: Color(0xff2454A9),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mood tracker'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
