import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final Duration period;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.period = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.period, vsync: this);

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutSine));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? AppColors.shimmerBase;
    final highlightColor = widget.highlightColor ?? AppColors.shimmerHighlight;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [_animation.value - 0.3, _animation.value, _animation.value + 0.3].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
