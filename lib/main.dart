import 'package:flutter/material.dart';
import 'package:flutter_unit_test_tutorial/domain/news_change_notifier.dart';
import 'package:flutter_unit_test_tutorial/pages/home_page.dart';
import 'package:flutter_unit_test_tutorial/services/news_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News App',
        home: ChangeNotifierProvider(
          create: (_) => NewsChangeNotifier(NewsService()),
          child: HomePage(),
        ));
  }
}
