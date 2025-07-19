import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/extensions/string_extensions.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/article/image.dart';
import 'package:news_app/shared/widgets/shimmer/shimmer_box.dart';

class ArticleGridCard extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;

  const ArticleGridCard({super.key, this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 2.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildImageSection(context)),
          Expanded(child: _buildInfoSection(context, theme)),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) => article == null ? ShimmerBox() : ArticleImage(article!.image);

  Widget _buildInfoSection(BuildContext context, ThemeData theme) {
    if (article == null) return _buildInfoShimmer();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(article!.title, style: theme.textTheme.titleSmall, maxLines: 3, overflow: TextOverflow.ellipsis),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Text(
              '${article!.source.name} • ${article!.publishedAt.toRelativeTime()}',
              style: theme.textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
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
}
