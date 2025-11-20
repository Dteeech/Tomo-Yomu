// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tomoyomu/features/manga/data/repositories/jikan_repository_impl.dart';
import 'package:tomoyomu/features/manga/presentation/providers/discover_provider.dart';
import 'package:tomoyomu/features/navigation/presentation/pages/main_navigation.dart';
import 'package:tomoyomu/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:tomoyomu/features/splash/splash_screen.dart';
import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {

  final http.Client httpClient;

  const MyApp({
    super.key,
    required this.httpClient,
  });

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DiscoverProvider(
            repository: JikanMangaRepositoryImpl(
              httpClient: httpClient, 
            ),
          ),
        ),
      ],
      
      child: MaterialApp(
        title: 'tomoyomu',
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            backgroundColor: Color(0xFF2B2D42),
            elevation: 0,
            centerTitle: true,
          ),
          scaffoldBackgroundColor: const Color(0xFF2B2D42),
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          AppRoutes.splash: (context) => const SplashScreen(),
          AppRoutes.main: (context) => const MainNavigation(),
          AppRoutes.onboarding: (context) => const OnboardingScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Erreur')),
              body: Center(
                child: Text('Page "${settings.name}" introuvable'),
              ),
            ),
          );
        },
      ),
    );
  }
}
