import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/features/news/data/dtos/news_request_dto.dart';
import 'package:news_app/features/news/data/dtos/news_response_dto.dart';

/// Abstract data source for fetching news articles from a remote API.
/// has [getArticles] method that takes a [NewsRequestDto] and returns a [NewsResponseDto].
abstract class NewsRemoteDataSource {
  Future<NewsResponseDto> getArticles(NewsRequestDto request);
}

/// Implementation of the NewsRemoteDataSource that interacts with the remote API
/// get [apiClient] to make HTTP requests.
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiClient apiClient;

  NewsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<NewsResponseDto> getArticles(NewsRequestDto request) async {
    final response = await apiClient.get('/search', queryParameters: request.toQueryParams());

    return NewsResponseDto.fromJson(response.data);
  }
}
