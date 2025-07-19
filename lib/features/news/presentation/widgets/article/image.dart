import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/app_colors.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage(this.imageUrl, {this.height = double.infinity, this.width = double.infinity, super.key});

  final String? imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width, child: imageUrl != null ? _buildImage() : _buildPlaceholder());
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.border,
        child: Icon(Icons.image, color: AppColors.textSecondary, size: 32.w),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.border,
        child: Icon(Icons.broken_image, color: AppColors.textSecondary, size: 32.w),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return ColoredBox(
      color: AppColors.border,
      child: Icon(Icons.article, color: AppColors.textSecondary, size: 32.w),
    );
  }
}
