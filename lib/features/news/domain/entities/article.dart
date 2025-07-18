import 'package:equatable/equatable.dart';

/// Represents a news article with its details.
class Article extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String? image;
  final String publishedAt;
  final ArticleSource source;

  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.publishedAt,
    required this.source,
    this.image,
  });

  @override
  List<Object?> get props => [id, title, description, content, url, image, publishedAt, source];
}

/// Represents the source of a news article.
class ArticleSource extends Equatable {
  final String id;
  final String name;
  final String url;

  const ArticleSource({required this.id, required this.name, required this.url});

  @override
  List<Object> get props => [id, name, url];
}
