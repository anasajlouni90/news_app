import 'package:news_app/models/source_model.dart';

class ArticleModel {
  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String img;
  final String date;
  final String content;
  String publishedAt;

  ArticleModel(this.source, this.author, this.title, this.description, this.url,
      this.img, this.date, this.content, this.publishedAt);

  ArticleModel.fromJson(Map<String, dynamic> json)
      : source = SourceModel.fromJson(json["source"]),
        author = json["author"],
        title = json["title"],
        description = json["description"],
        url = json["url"],
        img = json["urlToImage"],
        date = json["publishedAt"],
        content = json["content"],
        publishedAt = json["publishedAt"];
}
