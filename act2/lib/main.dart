import 'package:flutter/material.dart';

void main() {
  runApp(RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      themeMode: _themeMode,
      home: HomeScreen(
        changeTheme: changeTheme,
        themeMode: _themeMode,
      ),
    );
  }
}

//homescreen
class HomeScreen extends StatelessWidget {
  final Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  const HomeScreen({
    super.key,
    required this.changeTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Theme Demo")),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: themeMode == ThemeMode.light
                      ? const Color.fromARGB(255, 58, 163, 20)
                      : const Color.fromARGB(255, 4, 41, 162),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Center(
                  child: Text(
                    "Mobile App\nDevelopment Testing",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsScreen(
                        changeTheme: changeTheme,
                        themeMode: themeMode,
                      ),
                    ),
                  );
                },
                child: const Text("Go to Settings"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//setings
class SettingsScreen extends StatelessWidget {
  final Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  const SettingsScreen({
    super.key,
    required this.changeTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: SwitchListTile(
          title: const Text("Dark Mode"),
          value: themeMode == ThemeMode.dark,
          onChanged: (value) {
            changeTheme(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
      ),
    );
  }
}


