import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomoyomu/features/home/presentation/pages/home_screen.dart';
import 'package:tomoyomu/features/manga/presentation/pages/discover_page.dart';
import 'package:tomoyomu/features/splash/splash_screen.dart';
import 'features/auth/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ANCIENNE VERSION (avec erreur)
    // return MultiProvider(
    //   providers: [], // 👈 Liste vide = crash
    //   child: MaterialApp(...),
    // );

    // NOUVELLE VERSION (sans Provider pour l'instant)
    return MaterialApp(
      title: 'tomoyomu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // 🗺️ Configuration des routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/discover': (context) => const DiscoverPage(),
        // Futures routes :
        // '/onboarding': (context) => const OnboardingScreen(),
        // '/manga-details': (context) => const MangaDetailsScreen(),
        // '/add-manga': (context) => const AddMangaScreen(),
        // '/discover': (context) => const DiscoverScreen(),
      },
      // 404x
       onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Erreur')),
            body: Center(
              child: Text('Page "${settings.name}" introuvable 🔍'),
            ),
          ),
        );
      },
    );
  }
}
