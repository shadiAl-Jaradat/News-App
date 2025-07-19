import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/injection/service_locator.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_event.dart';
import 'package:news_app/features/news/presentation/bloc/search/search_cubit.dart';
import 'package:news_app/features/news/presentation/bloc/view_mode/view_mode_cubit.dart';

/// Wrap all news-related BLoCs into one reusable widget that can be placed at the root of the news feature
class NewsFeatureBlocWrapper extends StatelessWidget {
  final Widget child;

  const NewsFeatureBlocWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(create: (context) => locator<NewsBloc>()..add(const GetNewsEvent())),

        BlocProvider<SearchCubit>(create: (context) => locator<SearchCubit>()),

        BlocProvider<ViewModeCubit>(create: (context) => locator<ViewModeCubit>()),
      ],
      child: child,
    );
  }
}
