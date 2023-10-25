import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_test_tutorial/domain/news_change_notifier.dart';
import 'package:flutter_unit_test_tutorial/models/articles.dart';
import 'package:flutter_unit_test_tutorial/pages/article_page.dart';
import 'package:flutter_unit_test_tutorial/pages/home_page.dart';
import 'package:flutter_unit_test_tutorial/services/news_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;

  setUp(
    () {
      mockNewsService = MockNewsService();
    },
  );

  final articlesFromService = [
    Article(title: 'title1', description: 'description1'),
    Article(title: 'title2', description: 'description2'),
    Article(title: 'title3', description: 'description3'),
  ];

  void arrangeArticles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((_) async => articlesFromService);
  }

  Widget buildSubject() {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsService),
        child: const HomePage(),
      ),
    );
  }

  testWidgets(
    'Tapping on the first article excerpt opens the article where the full article content is displayed',
    (WidgetTester tester) async {
      arrangeArticles();
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();
      await tester.tap(find.text('title1'));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(ArticlePage), findsOneWidget);

      expect(find.text('title1'), findsOneWidget);
      expect(find.text('description1'), findsOneWidget);
    },
  );
}
