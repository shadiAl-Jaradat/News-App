import 'package:dartz/dartz.dart';
import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

/// Abstract repository for fetching news articles.
abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getArticles({String? query});

  Future<Either<Failure, List<Article>>> getArticlesFromMockData();
}
