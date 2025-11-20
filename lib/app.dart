// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tomoyomu/features/manga/data/repositories/jikan_repository_impl.dart';
import 'package:tomoyomu/features/manga/domain/entities/manga_entity.dart';
import 'package:tomoyomu/features/manga/presentation/pages/manga_details_page.dart';
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
            backgroundColor: Color(0xFF1A1A2E),
            elevation: 0,
            centerTitle: true,
          ),
          scaffoldBackgroundColor: const Color(0xFF1A1A2E),
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.splash:
              return MaterialPageRoute(builder: (_) => const SplashScreen());

            case AppRoutes.onboarding:
              return MaterialPageRoute(
                  builder: (_) => const OnboardingScreen());

            case AppRoutes.main:
              return MaterialPageRoute(builder: (_) => const MainNavigation());

            case AppRoutes.mangaDetail: // NOUVELLE ROUTE
              final manga = settings.arguments as Manga; // Récupère l'argument
              return MaterialPageRoute(
                builder: (_) => MangaDetailPage(manga: manga),
              );

            default:
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body:
                      Center(child: Text('Route inconnue : ${settings.name}')),
                ),
              );
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Erreur')),
              body: Center(
                child: Text('Route inconnue : ${settings.name}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
