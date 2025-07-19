import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:news_app/features/news/data/dtos/news_response_dto.dart';

abstract class NewsMockDataSource {
  Future<NewsResponseDto> getArticles();
}

class NewsMockDataSourceImpl implements NewsMockDataSource {
  NewsMockDataSourceImpl();

  @override
  Future<NewsResponseDto> getArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    final String jsonString = await rootBundle.loadString('lib/features/news/data/data_sources/mock_data.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return NewsResponseDto.fromJson(jsonMap);
  }
}
