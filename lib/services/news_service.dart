import 'package:flutter_unit_test_tutorial/models/articles.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class NewsService {
  //Simulating a remote database
  final _articles = List.generate(
    10,
    (index) => Article(
      title: lorem(paragraphs: 1, words: 3),
      description: lorem(paragraphs: 10, words: 500),
    ),
  );

  Future<List<Article>> getArticles() async {
    await Future.delayed(const Duration(seconds: 3));
    return _articles;
  }
}
