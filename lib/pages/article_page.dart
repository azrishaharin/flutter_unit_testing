import 'package:flutter/material.dart';
import 'package:flutter_unit_test_tutorial/models/articles.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(article.title),
            Text(article.description),
          ],
        ),
      )),
    );
  }
}
