import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/data/data_sources/news_mock_datasource.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/data/dtos/news_request_dto.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/data/data_sources/news_remote_datasource.dart';

/// Implementation of the NewsRepository that interacts with the remote data source
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsMockDataSource remoteMockDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({required this.remoteDataSource, required this.remoteMockDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Article>>> getArticles({String? query}) async {
    if (!await networkInfo.isConnected) return const Left(NetworkFailure());

    try {
      final response = await remoteDataSource.getArticles(NewsRequestDto(query: (query?.isNotEmpty ?? false) ? query : 'latest news'));
      return Right(response.articles);
    } on DioException catch (dioError) {
      if (dioError.error is ServerException) {
        final serverException = dioError.error as ServerException;
        return Left(ServerFailure(message: serverException.message));
      } else if (dioError.error is NetworkException) {
        final networkException = dioError.error as NetworkException;
        return Left(NetworkFailure(message: networkException.message));
      }
      return const Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getArticlesFromMockData() {
    final response = remoteMockDataSource.getArticles();
    return response.then((value) => Right(value.articles));
  }
}
