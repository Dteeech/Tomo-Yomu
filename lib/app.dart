import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomoyomu/features/manga/presentation/pages/discover_page.dart';
import 'features/auth/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ❌ ANCIENNE VERSION (avec erreur)
    // return MultiProvider(
    //   providers: [], // 👈 Liste vide = crash
    //   child: MaterialApp(...),
    // );

    // ✅ NOUVELLE VERSION (sans Provider pour l'instant)
    return MaterialApp(
      title: 'tomoyomu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DiscoverPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}