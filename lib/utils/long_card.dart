import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/constant/date_formatter.dart';
import 'package:news_app/model/newsmodel.dart';
import 'package:news_app/more_info_news.dart';

class BigCard extends StatelessWidget {
  final Article article;
  const BigCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.all(4),
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
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(article.title.toString(),
                  textAlign: TextAlign.start, style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500)),
              Text(article.description.toString(),
                  textAlign: TextAlign.start,
                  style: textTheme.titleSmall!
                      .copyWith(fontWeight: FontWeight.w400, color: theme.colorScheme.onSurface.withOpacity(0.8))),
              Align(
                alignment: Alignment.centerRight,
                child: Text("Published ${dateFormatter(article.publishedAt.toString(), "mm:ss")}",
                    style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400, color: theme.colorScheme.secondary)),
              ),
              if (article.urlToImage!.isNotEmpty) ...[
                Container(
                  height: 450,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(article.urlToImage.toString()), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
              const Gap(10),
              Align(
                alignment: Alignment.centerRight,
                child: Text("${article.source?.name.toString()} • ${article.author}",
                    textAlign: TextAlign.right, style: textTheme.bodySmall),
              ),
              const Gap(5),
            ],
          ),
        ),
      ),
    );
  }
}
