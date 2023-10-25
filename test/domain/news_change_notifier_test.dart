import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_test_tutorial/domain/news_change_notifier.dart';
import 'package:flutter_unit_test_tutorial/models/articles.dart';
import 'package:flutter_unit_test_tutorial/services/news_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut;
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test('should get articles from the service', () {
    expect(sut.articles, []);
    expect(sut.isLoading, false);
  });
  group('getArticles', () {
    final articlesFromService = [
      Article(title: 'title1', description: 'description1'),
      Article(title: 'title2', description: 'description2'),
      Article(title: 'title3', description: 'description3'),
    ];

    void arrangeArticles() {
      when(() => mockNewsService.getArticles())
          .thenAnswer((_) async => articlesFromService);
    }

    test("get articles using the NewsService", () async {
      arrangeArticles();
      await sut.getArticles();
      verify(() => mockNewsService.getArticles()).called(1);
      verifyNoMoreInteractions(mockNewsService);
    });

    test("""indicates loading of data, 
    sets articles to the ones from the service, 
    indicates that data is not being loaded anymore""", () async {
      arrangeArticles();
      final future = sut.getArticles();
      expect(sut.isLoading, true);
      await future;
      expect(sut.articles, articlesFromService);
      expect(sut.isLoading, false);
    });
  });
}
