import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/core/routes/app_router.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/extensions/string_extensions.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.7,
            pinned: true,
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(background: _buildHeroImage(context)),
            leading: IconButton(
              icon: Container(
                decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                child: Center(child: Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 24)),
              ),
              onPressed: () => AppRouter.goBack(context),
            ),
          ),

          SliverToBoxAdapter(child: _buildArticleContent(context, theme)),
        ],
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    if (article.image == null) {
      return Container(
        color: AppColors.border,
        child: Center(
          child: Icon(Icons.article, size: 64.w, color: AppColors.textSecondary),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: article.image!,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.border,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.textSecondary, strokeWidth: 2.w),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.border,
        child: Center(
          child: Icon(Icons.broken_image, size: 64.w, color: AppColors.textSecondary),
        ),
      ),
    );
  }

  Widget _buildArticleContent(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article.title, style: theme.textTheme.headlineMedium),
          SizedBox(height: 16.h),
          _buildMetadata(context, theme),

          if (article.description.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Text(
              article.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary.withValues(alpha: 0.8),
              ),
            ),
          ],

          Divider(height: 20.h),

          Text(article.content, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6, color: AppColors.textPrimary)),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.w,
      children: [
        Text(
          article.source.name,
          style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        Text(article.publishedAt.toRelativeTime(), style: theme.textTheme.labelSmall?.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}
