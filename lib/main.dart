import 'package:flutter/material.dart';
import 'app.dart';
import 'package:http/http.dart' as http;

void main() {
  final httpClient = http.Client();
   runApp(
    MyApp(httpClient: httpClient),
  );
}
