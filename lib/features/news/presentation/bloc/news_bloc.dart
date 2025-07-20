import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/use_cases/get_articles.dart';
import 'package:news_app/features/news/domain/use_cases/get_mock_articles.dart';
import 'package:news_app/features/news/presentation/bloc/news_event.dart';
import 'package:news_app/features/news/presentation/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetArticles getArticles;
  final GetMockArticles getMockArticles;

  NewsBloc({required this.getArticles, required this.getMockArticles}) : super(const NewsInitial()) {
    on<GetNewsEvent>(_onGetNews);
    on<RefreshNewsEvent>(_onRefreshNews);
  }

  void _onGetNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    if (!event.isRefresh) {
      emit(const NewsLoading());
    } else {
      if (state is NewsLoaded) {
        emit(NewsRefreshing(currentArticles: (state as NewsLoaded).articles));
      } else {
        emit(const NewsLoading());
      }
    }

    final result = await getArticles(query: event.query);

    /// For testing purposes, we use mock data uncomment the line below and comment the line above
    // final result = await getMockArticles();

    result.fold(
      (failure) {
        final cachedArticles = state is NewsLoaded ? (state as NewsLoaded).articles : <Article>[];
        emit(NewsError(message: failure.message, cachedArticles: cachedArticles));
      },
      (articles) {
        if (articles.isEmpty) {
          emit(NewsEmpty(searchQuery: event.query));
        } else {
          emit(NewsLoaded(articles: articles, searchQuery: event.query, isSearchResult: event.query?.isNotEmpty == true));
        }
      },
    );
  }

  void _onRefreshNews(RefreshNewsEvent event, Emitter<NewsState> emit) async => add(GetNewsEvent(query: event.query, isRefresh: true));

  List<Article> get currentArticles {
    return switch (state.runtimeType) {
      const (NewsLoaded) => (state as NewsLoaded).articles,
      const (NewsRefreshing) => (state as NewsRefreshing).currentArticles,
      const (NewsError) => (state as NewsError).cachedArticles,
      _ => [],
    };
  }

  bool get isSearchActive => state is NewsLoaded ? (state as NewsLoaded).isSearchResult : false;
}
