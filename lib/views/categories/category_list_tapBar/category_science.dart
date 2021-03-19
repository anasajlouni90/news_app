import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_category_new.bloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/models/articleModels.dart';
import 'package:news_app/response/article_response.dart';
import 'package:news_app/views/atricle_view.dart';
import 'package:news_app/views/blog_tile.dart';
import 'package:share/share.dart';

class CategoryNewsScience extends StatefulWidget {
  final language;
  CategoryNewsScience({this.language});

  @override
  _CategoryNewsScienceState createState() => _CategoryNewsScienceState();
}

class _CategoryNewsScienceState extends State<CategoryNewsScience> {
  @override
  void initState() {
    super.initState();
    getCategoryNewsClassBloc..getCategoryNewsScience(widget.language);
  }

  Future<void> _refresh() async {
    await getCategoryNewsClassBloc
      ..getCategoryNewsScience(widget.language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<ArticleResponse>(
          stream: getCategoryNewsClassBloc.subject.stream,
          builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return buildErrorWidget(snapshot.data.error);
              }
              return _buildCategoryNewsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.error);
            } else {
              return buildLoadingWidget();
            }
          },
        ));
  }

  Widget _buildCategoryNewsWidget(ArticleResponse data) {
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

