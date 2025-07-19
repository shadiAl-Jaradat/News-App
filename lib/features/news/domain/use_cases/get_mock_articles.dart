import 'package:dartz/dartz.dart';
import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetMockArticles {
  final NewsRepository repository;

  GetMockArticles(this.repository);

  Future<Either<Failure, List<Article>>> call() async => await repository.getArticlesFromMockData();
}
