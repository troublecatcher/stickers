import 'package:dqed1/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'news_details.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) => NewsDetails(
                            news: newsList[index],
                            index: index,
                          ))),
              child: ListTile(
                leading: Hero(
                  tag: 'item$index',
                  child: Image.network(newsList[index].imageLink,
                      width: 100, height: 100, fit: BoxFit.cover),
                ),
                title: Text(
                  newsList[index].title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  newsList[index].content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            );
          }),
    );
  }
}
