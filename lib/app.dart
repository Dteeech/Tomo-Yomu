import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomoyomu/features/home/presentation/pages/home_screen.dart';
import 'package:tomoyomu/features/manga/presentation/pages/discover_page.dart';
import 'package:tomoyomu/features/navigation/presentation/pages/main_navigation.dart';
import 'package:tomoyomu/features/splash/splash_screen.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'core/routes/app_routes.dart';
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
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.main: (context) => const MainNavigation(),
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
