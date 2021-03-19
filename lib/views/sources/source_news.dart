import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_source_news_bloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/models/articleModels.dart';
import 'package:news_app/response/article_response.dart';
import 'package:news_app/views/atricle_view.dart';
import 'package:news_app/views/blog_tile.dart';
import 'package:share/share.dart';

class SourceNews extends StatefulWidget {
  final String sourceId;
  SourceNews({this.sourceId});

  @override
  _SourceNewsState createState() => _SourceNewsState();
}

class _SourceNewsState extends State<SourceNews> {
  @override
  void initState() {
    super.initState();
    getSourceNewsBloc..getSourceNews(widget.sourceId);
  }

  Future<void> _refresh() async {
    await getSourceNewsBloc
      ..getSourceNews(widget.sourceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getTranslated(context, 'news'),
                  style: TextStyle(
                      color: Colors.lightBlueAccent[400], fontSize: 27),
                ),
              ],
            ),
            elevation: 0.0,
          ),
        ),
        body: StreamBuilder<ArticleResponse>(
          stream: getSourceNewsBloc.subject.stream,
          builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return buildErrorWidget(snapshot.data.error);
              }
              return _buildSourceNewsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.error);
            } else {
              return buildLoadingWidget();
            }
          },
        ));
  }

  Widget _buildSourceNewsWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;

    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              getTranslated(context, "No more news"),
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return RefreshIndicator(
        onRefresh: () => _refresh(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                //Blogs
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return BlogTile(
                          imageUrl: (articles[index].img) == null
                              ? ("https://jpublicrelations.com/wp-content/uploads/2015/12/placeholder-1.png.1236x617_default.png")
                              : (articles[index].img),
                          title: articles[index].title,
                          desc: (articles[index].description) == null
                              ? (".")
                              : (articles[index].description),
                          sourceName: articles[index].source.name,
                          date: articles[index].publishedAt,
                          url: articles[index].url);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
