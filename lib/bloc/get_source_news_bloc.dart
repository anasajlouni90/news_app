import 'package:flutter/material.dart';
import 'package:news_app/response/news_repository.dart';
import 'package:news_app/response/article_response.dart';
import 'package:rxdart/rxdart.dart';

class GetSourceNewsBloc {
  final NewsRepository _repository = NewsRepository();
   BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getSourceNews(String sourceId) async {
    ArticleResponse response = await _repository.getSourceNews(sourceId);
    _subject.sink.add(response);
  }

   

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getSourceNewsBloc = GetSourceNewsBloc();
