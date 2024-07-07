import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Mood tracker',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffF5F9FF),
          surfaceTintColor: Color(0xffF5F9FF),
        ),
        scaffoldBackgroundColor: const Color(0xffF5F9FF),
        colorScheme: const ColorScheme.light(
          primary: Color(0xff3D5BA9),
          secondary: Color(0xff79B1F1),
          onSurface: Color.fromARGB(255, 34, 51, 93),
          inversePrimary: Color(0xff2454A9),
        ),
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
          overlayColor: WidgetStateColor.transparent,
        )),
        useMaterial3: true,
      ),
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
          children: const [
            Text('hello'),
          ],
        ),
      ),
    );
  }
}
