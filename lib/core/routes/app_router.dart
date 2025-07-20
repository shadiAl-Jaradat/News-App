import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/screens/article_details_screen.dart';
import 'package:news_app/features/news/presentation/screens/home_screen.dart';
import 'package:news_app/shared/screens/error_screen.dart';
import 'route_paths.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: true,
    routes: [
      // Home Route
      GoRoute(path: RoutePaths.home, name: RouteNames.home, builder: (context, state) => const HomePage()),

      // Article Details Route
      GoRoute(
        path: RoutePaths.articleDetails,
        name: RouteNames.articleDetails,
        builder: (context, state) {
          final article = state.extra as Article?;

          if (article == null) return const ErrorScreen(message: 'Article not found');

          return ArticleDetailsScreen(article: article);
        },
      ),
    ],

    errorBuilder: (context, state) => ErrorScreen(message: 'Page not found: ${state.path}'),
  );

  /// Helper navigation methods

  static void goHome(BuildContext context) => context.go(RoutePaths.home);

  static void goToArticleDetails(BuildContext context, Article article) => context.push(RoutePaths.articleDetails, extra: article);

  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      goHome(context);
    }
  }

  static void replaceWithHome(BuildContext context) => context.pushReplacement(RoutePaths.home);
}
