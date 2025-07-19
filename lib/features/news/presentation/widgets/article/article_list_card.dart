import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/extensions/string_extensions.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/article/image.dart';
import 'package:news_app/shared/widgets/shimmer/shimmer_box.dart';

class ArticleListCard extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;

  const ArticleListCard({super.key, this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: getListCardHeight(context),
        child: Row(
          children: [
            Expanded(flex: 3, child: _buildImageSection(context)),
            Expanded(flex: 7, child: _buildInfoSection(context, theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) => article == null ? ShimmerBox() : ArticleImage(article!.image);

  Widget _buildInfoSection(BuildContext context, ThemeData theme) {
    if (article == null) return _buildInfoShimmer();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Text(article!.title, style: theme.textTheme.titleMedium, maxLines: 3, overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${article!.source.name} • ${article!.publishedAt.toRelativeTime()}',
              style: theme.textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(height: 10.h, radius: 4.r),
          ShimmerBox(height: 10.h, radius: 4.r),
          ShimmerBox(height: 10.h, radius: 4.r),
        ],
      ),
    );
  }

  double getListCardHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) return 100.h; // Very small screens
    if (screenWidth < 600) return 120.h; // Mobile
    if (screenWidth < 900) return 140.h; // Small tablet
    if (screenWidth < 1200) return 160.h; // Large tablet
    return 180.h; // Desktop
  }
}
