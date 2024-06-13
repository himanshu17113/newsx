import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/constant/date_formatter.dart';
import 'package:news_app/model/newsmodel.dart';
import 'package:news_app/more_info_news.dart';

class Cards extends StatelessWidget {
  final Article article;

  const Cards({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Card(
      // color: theme.colorScheme.surfaceContainerHighest,
      margin: const EdgeInsets.all(5),
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((article.urlToImage != null && article.urlToImage!.isNotEmpty)) ...[
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(article.urlToImage.toString()), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
              const Gap(10),
              Text("${article.source?.name.toString()} • ${dateFormatter(article.publishedAt.toString(), "mm:ss")}",
                  style: textTheme.titleSmall),
              const Gap(5),
              Text(article.title.toString(), textAlign: TextAlign.start, style: textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
