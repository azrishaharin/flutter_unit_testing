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
  setUp(() {
    mockNewsService = MockNewsService();
  });

  final articlesFromService = [
    Article(title: 'title1', description: 'description1'),
    Article(title: 'title2', description: 'description2'),
    Article(title: 'title3', description: 'description3'),
  ];

  void arrangeArticles() {
    when(() => mockNewsService.getArticles())
        .thenAnswer((_) async => articlesFromService);
  }

  void arrangeArticlesDelay() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 3));
      return articlesFromService;
    });
  }

  Widget buildSubject() {
    return MaterialApp(
        title: 'News App',
        home: ChangeNotifierProvider(
          create: (_) => NewsChangeNotifier(mockNewsService),
          child: const HomePage(),
        ));
  }

  testWidgets(
    'title is displayed',
    (WidgetTester tester) async {
      arrangeArticles();
      await tester.pumpWidget(buildSubject());
      expect(find.text('News'), findsOneWidget);
    },
  );

  testWidgets(
    'loading indicator is displayed while waiting for articles',
    (WidgetTester tester) async {
      arrangeArticlesDelay();
      await tester.pumpWidget(buildSubject());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'displays list of articles',
    (WidgetTester tester) async {
      arrangeArticles();
      await tester.pumpWidget(buildSubject());
      expect(find.byType(ListView), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(Card), findsNWidgets(3));
    },
  );

  testWidgets(
    'displays article title',
    (WidgetTester tester) async {
      arrangeArticles();
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();
      for (final article in articlesFromService) {
        expect(find.text(article.title), findsOneWidget);
      }
    },
  );

  testWidgets('navigates to article detail page', (WidgetTester tester) async {
    arrangeArticles();
    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();
    for (final article in articlesFromService) {
      expect(find.text(article.title), findsOneWidget);
      await tester.tap(find.text(article.title));
      await tester.pump();
      expect(find.byType(ArticlePage), findsOneWidget);
    }
  });
}

// NOTES
// 1. find.byKey is useful when theres multiple same widget
