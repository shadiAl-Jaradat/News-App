import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/view_mode/view_mode_cubit.dart';

class FaButton extends StatelessWidget {
  const FaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewModeCubit, ViewModeState>(
      builder: (context, viewState) {
        return ViewToggleFab(isGridView: viewState.isGridView, onToggle: () => _handleToggle(context));
      },
    );
  }

  void _handleToggle(BuildContext context) {
    context.read<ViewModeCubit>().toggleView();
  }
}

class ViewToggleFab extends StatefulWidget {
  final bool isGridView;
  final VoidCallback onToggle;

  const ViewToggleFab({super.key, required this.isGridView, required this.onToggle});

  @override
  State<ViewToggleFab> createState() => _ViewToggleFabState();
}

class _ViewToggleFabState extends State<ViewToggleFab> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ViewToggleFab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isGridView != widget.isGridView) {
      _playAnimation();
    }
  }

  void _playAnimation() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  void _onFabTap() {
    _playAnimation();
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FloatingActionButton(
            onPressed: _onFabTap,
            child: AnimatedRotation(
              turns: widget.isGridView ? 0.0 : 0.5,
              duration: const Duration(milliseconds: 200),
              child: Icon(widget.isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded, size: 24),
            ),
          ),
        );
      },
    );
  }
}
