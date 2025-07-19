import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/bloc/bloc_wrapper.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_event.dart';
import 'package:news_app/features/news/presentation/bloc/news_state.dart';
import 'package:news_app/features/news/presentation/bloc/search/search_cubit.dart';
import 'package:news_app/features/news/presentation/bloc/view_mode/view_mode_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/home/empty_view.dart';
import 'package:news_app/features/news/presentation/widgets/home/news_search_bar.dart';
import 'package:news_app/features/news/presentation/widgets/home/fa_button.dart';
import 'package:news_app/shared/widgets/error_view.dart';
import 'package:news_app/features/news/presentation/widgets/home/grid_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NewsFeatureBlocWrapper(
      child: Scaffold(floatingActionButton: FaButton(), body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Insight Now', style: theme.textTheme.headlineLarge),
            _SearchSection(),
            Expanded(child: _NewsContentSection()),
          ],
        ),
      ),
    );
  }
}

/// Search section with BLoC listener for reactive search
class _SearchSection extends StatelessWidget {
  const _SearchSection();

  void _handleSearchChange(BuildContext context, String query) => context.read<SearchCubit>().searchChanged(query);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listenWhen: (previous, current) => previous.searchQuery != current.searchQuery,
      listener: (context, searchState) => context.read<NewsBloc>().add(GetNewsEvent(query: searchState.searchQuery)),
      child: NewsSearchBar(onSearchChanged: (query) => _handleSearchChange(context, query)),
    );
  }
}

/// News content section that handles different states
class _NewsContentSection extends StatelessWidget {
  const _NewsContentSection();

  void _handleRetry(BuildContext context) {
    final searchState = context.read<SearchCubit>().state;
    context.read<NewsBloc>().add(GetNewsEvent(query: searchState.searchQuery));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, newsState) {
        return BlocBuilder<ViewModeCubit, ViewModeState>(
          builder: (context, viewState) => _buildContentByState(context, newsState, viewState.isGridView),
        );
      },
    );
  }

  Widget _buildContentByState(BuildContext context, NewsState newsState, bool isGridView) {
    return switch (newsState) {
      NewsLoading() => NewsGridListView(isGridView: isGridView),
      NewsError() => ErrorView(error: newsState, onRetry: () => _handleRetry(context)),
      NewsEmpty() => EmptyView(emptyState: newsState),
      NewsLoaded() => _NewsContentView(articles: newsState.articles, isGridView: isGridView),
      NewsRefreshing() => _NewsContentView(articles: newsState.currentArticles, isGridView: isGridView),
      _ => const SizedBox.shrink(),
    };
  }
}

/// News content view displaying articles in grid or list format
class _NewsContentView extends StatelessWidget {
  const _NewsContentView({required this.articles, required this.isGridView});

  final List<Article> articles;
  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: NewsGridListView(isGridView: isGridView, articles: articles),
    );
  }

  Future<void> _handleRefresh(BuildContext context) async {
    final searchState = context.read<SearchCubit>().state;
    context.read<NewsBloc>().add(RefreshNewsEvent(query: searchState.searchQuery));
  }
}
