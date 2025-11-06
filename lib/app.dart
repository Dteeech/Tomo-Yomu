import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add your Provider providers here
      ],
      child: MaterialApp(
        title: 'tomoyomu',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
