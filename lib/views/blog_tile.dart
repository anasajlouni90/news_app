import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/views/atricle_view.dart';
import 'package:share/share.dart';

class BlogTile extends StatefulWidget {
  final String imageUrl, title, desc, sourceName, date, url;

  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.sourceName,
      @required this.date,
      @required this.url});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: widget.url,
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
                        widget.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0)),
                          child: CachedNetworkImage(
                              imageUrl: widget.imageUrl,
                              width: 120,
                              height: 60,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.sourceName,
                            style: TextStyle(color: Colors.red, fontSize: 9.0),
                          ),
                          Text(
                            widget.date,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 9.0),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.grey[500],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 5),
                      child: Text(
                        widget.desc,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Divider(
                      height: 10,
                      color: Colors.grey[500],
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
                            onPressed: () {
                              setState(() {
                                share(context);
                              });
                            },
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
      ),
    );
  }

  void share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final text = "${widget.url}";
    Share.share(text,
        subject: widget.desc,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
