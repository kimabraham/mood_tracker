import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/firebase_options.dart';
import 'package:mood_tracker/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        colorScheme: ColorScheme.light(
          primary: const Color(0xff3D5BA9),
          secondary: const Color(0xff79B1F1),
          surface: const Color(0xff79B1F1).withOpacity(0.1),
          onSurface: const Color.fromARGB(255, 34, 51, 93),
          inversePrimary: const Color(0xff2454A9),
          inverseSurface:
              const Color.fromARGB(255, 34, 51, 93).withOpacity(0.7),
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
