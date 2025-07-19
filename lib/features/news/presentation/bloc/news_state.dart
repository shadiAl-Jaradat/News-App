import 'package:equatable/equatable.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsRefreshing extends NewsState {
  final List<Article> currentArticles;

  const NewsRefreshing({required this.currentArticles});

  @override
  List<Object> get props => [currentArticles];
}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final String? searchQuery;
  final bool isSearchResult;

  const NewsLoaded({required this.articles, this.searchQuery, this.isSearchResult = false});

  @override
  List<Object> get props => [articles, searchQuery ?? '', isSearchResult];
}

class NewsError extends NewsState {
  final String message;
  final List<Article> cachedArticles;

  const NewsError({required this.message, this.cachedArticles = const []});

  @override
  List<Object> get props => [message, cachedArticles];
}

class NewsEmpty extends NewsState {
  final String? searchQuery;

  const NewsEmpty({this.searchQuery});

  @override
  List<Object> get props => [searchQuery ?? ''];
}
