import 'package:dartz/dartz.dart';
import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

/// Use case for fetching articles from the news repository.
class GetArticles {
  final NewsRepository repository;

  GetArticles(this.repository);

  Future<Either<Failure, List<Article>>> call({String? query}) async => await repository.getArticles(query: query);
}
