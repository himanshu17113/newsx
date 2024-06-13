import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constant/date_formatter.dart';
import 'package:news_app/model/newsmodel.dart';
import 'package:news_app/more_info_news.dart';

class SmallCard extends StatelessWidget {
  final Article article;

  const SmallCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) {
            return MoreInfoNews(
              date: formatDate(article.publishedAt.toString()),
              sourceName: article.source?.name,
              title: article.title,
              content: article.content,
              desc: article.description,
              image: article.urlToImage,
              sourceUrl: article.url,
            );
          }));
        },
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title.toString(),
                        style: theme.textTheme.titleLarge,
                      ),
                      if (article.description != null) ...[
                        Text(
                          article.description.toString(),
                          style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                        )
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${article.source?.name.toString()} • ${dateFormatter(article.publishedAt.toString(), "mm:ss")}",
                        //style: AppTextStyles.body2Regular
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
