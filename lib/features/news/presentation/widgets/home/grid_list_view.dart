import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/routes/app_router.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/presentation/widgets/article/article_grid_card.dart';
import 'package:news_app/features/news/presentation/widgets/article/article_list_card.dart';

class NewsGridListView extends StatelessWidget {
  final List<Article>? articles;
  final bool isGridView;

  const NewsGridListView({super.key, this.articles, required this.isGridView});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isGridView ? _buildGridView(context) : _buildListView(context),
    );
  }

  Widget _buildGridView(BuildContext context) {
    double cross = 180.w >= 500 ? 500 : 180.w;
    double main = 160.w >= 600 ? 600 : 160.w;

    return GridView.custom(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: cross,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: main,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: articles?.length ?? 10,
        (context, index) => _buildGridCard(context, articles?[index]),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      itemCount: articles?.length ?? 10,
      separatorBuilder: (context, index) => Divider(height: 20),
      itemBuilder: (context, index) => _buildListCard(context, articles?[index]),
    );
  }

  Widget _buildListCard(BuildContext context, Article? article) =>
      article == null ? ArticleListCard() : ArticleListCard(article: article, onTap: () => _handleArticleTap(context, article));

  Widget _buildGridCard(BuildContext context, Article? article) =>
      article == null ? ArticleGridCard() : ArticleGridCard(article: article, onTap: () => _handleArticleTap(context, article));

  void _handleArticleTap(BuildContext context, Article article) {
    AppRouter.goToArticleDetails(context, article);
  }
}
