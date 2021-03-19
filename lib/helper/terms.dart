import 'package:flutter/material.dart';
import 'package:news_app/localization/localization_constanst.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  getTranslated(context, 'news'),
                  style: TextStyle(
                      color: Colors.lightBlueAccent[400], fontSize: 27),
                ),
              ),
            ],
          ),
          elevation: 0.0,
          actions: [
            Opacity(opacity: 0),
            Icon(
              Icons.share,
              size: 50,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 50, 5, 5),
        child: Column(
          children: [
            Container(
                child:
                    Text("Terms of Service", style: TextStyle(fontSize: 30))),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                  child: Text(
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
                style: TextStyle(fontSize: 15),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
