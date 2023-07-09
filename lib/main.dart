import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/controllers/providers/time_provider.dart';
import 'package:todo_app_flutter/views/home_screen.dart';
import 'package:todo_app_flutter/views/splash_screen.dart';

import 'controllers/providers/theme_provider.dart';

void main() {
  runApp(
    const My_App(),
  );
}

class My_App extends StatefulWidget {
  const My_App({Key? key}) : super(key: key);

  @override
  State<My_App> createState() => _My_AppState();
}

class _My_AppState extends State<My_App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TimeProvider()),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          initialRoute: 'Splash_Screen',
          routes: {
            'Home_Screen': (context) => const Home_Page(),
            'Splash_Screen': (context) => const Splash_Page(),
          },
        );
      },
    );
  }
}
