import 'package:flutter/material.dart';
import 'package:flutter_unit_test_tutorial/domain/news_change_notifier.dart';
import 'package:flutter_unit_test_tutorial/pages/article_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsChangeNotifier>().getArticles(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Consumer<NewsChangeNotifier>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: value.articles.length,
            itemBuilder: (context, index) {
              final article = value.articles[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ArticlePage(
                              article: article,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        value.articles[index].title,
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
