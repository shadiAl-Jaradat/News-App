import 'package:news_app/features/news/domain/entities/article.dart';

class ArticleDto extends Article {
  const ArticleDto({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    required super.url,
    super.image,
    required super.publishedAt,
    required super.source,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) {
    return ArticleDto(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      image: json['image'],
      publishedAt: json['publishedAt'] ?? '',
      source: ArticleSourceDto.fromJson(json['source'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'image': image,
      'publishedAt': publishedAt,
      'source': (source as ArticleSourceDto).toJson(),
    };
  }
}

class ArticleSourceDto extends ArticleSource {
  const ArticleSourceDto({required super.id, required super.name, required super.url});

  factory ArticleSourceDto.fromJson(Map<String, dynamic> json) {
    return ArticleSourceDto(id: json['id'] ?? '', name: json['name'] ?? '', url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'url': url};
  }
}
