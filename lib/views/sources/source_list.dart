import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_source_bloc.dart';
import 'package:news_app/response/source_response.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/main_screen.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/views/main_screen2.dart';
import 'package:news_app/views/sources/source_news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SourceScreen extends StatefulWidget {
  final language;

  SourceScreen({this.language});
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  List<String> selecteditems = [];
  SharedPreferences preferences;

  bool _value = false;

  @override
  void initState() {
    super.initState();
    getSourcesBloc..getSources(widget.language);
    initSharedPrefernces();
  }

  Future<void> _refresh() async {
    getSourcesBloc..getSources(widget.language);
  }

  Future<void> initSharedPrefernces() async {
    preferences = await SharedPreferences.getInstance();
    readData();
  }

 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
        stream: getSourcesBloc.subject.stream,
        builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildSources(snapshot.data);
          }
          return Container();
        });
  }

  Widget _buildSources(SourceResponse data) {
    List<SourceModel> sources = data.sources;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "THE WORLD NEWS",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.lightBlueAccent[400], fontSize: 27),
              ),
            ],
          ),
          elevation: 0.0,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTranslated(context, 'Sources'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CheckboxListTile(
                title: Text(getTranslated(context, "Select all")),
                autofocus: false,
                activeColor: Colors.blue,
                checkColor: Colors.white,
                selected: _value,
                value: _value,
                onChanged: (bool value) {
                  setState(() {
                    _value = value;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen2()));
                  });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: sources.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.67,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  SourceNews(sourceId: sources[index].id)),
                        );
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(1.0, 1.0),
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: sources[index].id,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "images/logos/${sources[index].id}.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              child: Text(
                                sources[index].name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Checkbox(
                                value: sources[index].isSelected == !_value,
                                onChanged: (value) {
                                  setState(() {
                                    sources[index].isSelected =
                                        !sources[index].isSelected;
                                    if (sources[index].isSelected == true) {
                                      selecteditems
                                          .add(sources[index].id.toString());
                                    } else {
                                      selecteditems
                                          .remove(sources[index].id.toString());
                                    }
                                    saveData();
                                  });
                                  print(selecteditems);
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (selecteditems.isEmpty) {
              return Toast.show(
                  getTranslated(context, "Please selecet at least one source"),
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MainScreen(
                    sourccid: selecteditems
                        .reduce((value, element) => value + ',' + element),
                  ),
                ),
              );
            }
          });
        },
        tooltip: getTranslated(context, 'Go to my sources'),
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }

  Future<void> saveData() async {
    List<String> spList =
        selecteditems.map((item) => json.encode(item.toString())).toList();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('list', spList);
    print(spList);
  }

  readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      
    List<String> spList = preferences.getStringList('list');
    selecteditems =
        spList.map<String>((item) => jsonDecode(item.toString())).toList();
    if (selecteditems != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(
              sourccid: selecteditems
                  .reduce((value, element) => value + ',' + element),
            ),
          ));
    }
    setState(() {});
    print("reading : $selecteditems");
    return selecteditems;
  }
}
