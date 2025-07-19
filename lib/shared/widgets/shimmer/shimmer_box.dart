import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/shared/widgets/shimmer/shimmer_loading.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({this.width = double.infinity, this.height = double.infinity, this.radius, super.key});

  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: AppColors.shimmerBase, borderRadius: BorderRadius.circular(radius ?? 8.r)),
      ),
    );
  }
}
