import 'package:news_app/features/news/data/dtos/article_dto.dart';

class NewsResponseDto {
  final int totalArticles;
  final List<ArticleDto> articles;

  const NewsResponseDto({required this.totalArticles, required this.articles});

  factory NewsResponseDto.fromJson(Map<String, dynamic> json) {
    return NewsResponseDto(
      totalArticles: json['totalArticles'] ?? 0,
      articles: (json['articles'] as List<dynamic>?)?.map((articleJson) => ArticleDto.fromJson(articleJson)).toList() ?? [],
    );
  }
}
