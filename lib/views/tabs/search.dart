import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articleModels.dart';
import 'package:news_app/response/article_response.dart';
import 'package:news_app/bloc/search_bloc.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/views/atricle_view.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime startDate;
  DateTime endDate;
  DateTime today;

  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchBloc..search("");
    today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);
    startDate = today;
    endDate = today;
  }

  startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day, 0, 0, 0);
  endtOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day, 23, 59, 59);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          child: TextFormField(
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            controller: _searchController,
            onChanged: (changed) {
              searchBloc..search(_searchController.text);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey[100],
              suffixIcon: _searchController.text.length > 0
                  ? IconButton(
                      icon: Icon(
                        EvaIcons.backspaceOutline,
                        color: Colors.grey[500],
                        size: 16.0,
                      ),
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _searchController.clear();
                          searchBloc..search(_searchController.text);
                        });
                      })
                  : Icon(
                      EvaIcons.searchOutline,
                      color: Colors.grey[500],
                      size: 16.0,
                    ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.grey[100].withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.grey[100].withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30.0)),
              contentPadding: EdgeInsets.only(left: 15.0, right: 10.0),
              labelText: getTranslated(context, 'search_bar'),
              hintStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            autocorrect: false,
            autovalidate: true,
          ),
        ),
        Expanded(
            child: StreamBuilder<ArticleResponse>(
          stream: searchBloc.subject.stream,
          builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return Container();
              }
              return _buildSourceNewsWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Container();
            }
          },
        ))
      ],
    );
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
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleView(
                        blogUrl: articles[index].url,
                      ),
                    ),
                  );
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[500],
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(
                                1.0,
                                1.0,
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  articles[index].title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0)),
                                    image: DecorationImage(
                                        image: articles[index].img == null
                                            ? AssetImage(
                                                'images/img/placeholder.jpg')
                                            : NetworkImage(articles[index].img),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    width: 180,
                                    height: 1.0,
                                    color: Colors.black12,
                                  ),
                                  Container(
                                    width: 30,
                                    height: 3.0,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      articles[index].source.name,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 9.0),
                                    ),
                                    Text(
                                      articles[index].date,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 9.0),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey[500],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 15, left: 5),
                                child: Text(
                                  articles[index].description,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                                             Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 5),
                      child: Row(
                        children: [
                          Text(
                           getTranslated(context, "Share"),
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              EvaIcons.facebook,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              EvaIcons.twitter,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      Divider(
                        height: 10,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ));
          });
  }
}
