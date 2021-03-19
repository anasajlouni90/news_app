import 'package:news_app/response/news_repository.dart';
import 'package:news_app/response/article_response.dart';
import 'package:rxdart/rxdart.dart';

class GetTopHeadlinesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getHeadlines(language) async {
    ArticleResponse response = await _repository.getTopHeadlines(language);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
  
}
final getTopHeadlinesBloc = GetTopHeadlinesBloc();