import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/app_colors.dart';

class NewsSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final String? initialQuery;
  final String hintText;

  const NewsSearchBar({super.key, required this.onSearchChanged, this.initialQuery, this.hintText = 'Search news...'});

  @override
  State<NewsSearchBar> createState() => _NewsSearchBarState();
}

class _NewsSearchBarState extends State<NewsSearchBar> {
  late TextEditingController _controller;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _showClearButton = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text;
    final shouldShowClear = text.isNotEmpty;

    if (_showClearButton != shouldShowClear) setState(() => _showClearButton = shouldShowClear);

    widget.onSearchChanged(text);
  }

  void _clearSearch() => _controller.clear();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = 18.w > 30 ? 30.0 : 18.w;

    return SizedBox(
      height: 46.h < 44 ? 44 : 46.h,
      child: TextField(
        controller: _controller,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(fontSize: theme.textTheme.bodyMedium?.fontSize),
          filled: true,
          fillColor: AppColors.searchBackground,
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(focused: true),
          contentPadding: EdgeInsets.symmetric(vertical: 2.h),
          prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: iconSize),
          suffixIcon: _showClearButton
              ? Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: GestureDetector(
                    onTap: _clearSearch,
                    child: Icon(Icons.clear, color: AppColors.textSecondary, size: iconSize),
                  ),
                )
              : null,
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => widget.onSearchChanged(value),
      ),
    );
  }

  OutlineInputBorder _buildBorder({bool focused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: BorderSide(color: focused ? AppColors.primary : AppColors.border, width: focused ? 2 : 1),
    );
  }
}
