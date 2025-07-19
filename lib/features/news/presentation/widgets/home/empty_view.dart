import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/news/presentation/bloc/news_state.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({required this.emptyState, super.key});

  final NewsEmpty emptyState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSearchResult = emptyState.searchQuery?.isNotEmpty == true;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearchResult ? Icons.search_off : Icons.article_outlined,
              size: 64,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              isSearchResult ? 'No results found' : 'No news available',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            if (isSearchResult) ...[
              const SizedBox(height: 8),
              Text('Try a different search term', style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
