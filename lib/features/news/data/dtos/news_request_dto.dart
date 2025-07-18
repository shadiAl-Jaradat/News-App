import 'package:news_app/core/constants/api_constants.dart';

class NewsRequestDto {
  final String? query;
  final String? category;
  final String country;
  final String language;
  final int maxResults;

  const NewsRequestDto({
    this.query,
    this.category,
    this.country = ApiConstants.defaultCountry,
    this.language = ApiConstants.defaultLanguage,
    this.maxResults = ApiConstants.maxArticles,
  });

  Map<String, dynamic> toQueryParams() {
    return {
      'q': query?.isNotEmpty == true ? query : 'latest news',
      if (category != null) 'category': category,
      'country': country,
      'lang': language,
      'max': maxResults,
    };
  }
}
