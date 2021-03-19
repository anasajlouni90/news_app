import 'package:news_app/response/news_repository.dart';
import 'package:news_app/response/article_response.dart';
import 'package:rxdart/rxdart.dart';

class GetCategoryNewsClassBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getCategoryNews(String category,language) async {
    ArticleResponse response = await _repository.getCategoryNews(category,language);
    _subject.sink.add(response);
  }
    getCategoryNewsBusiness(language) async {
    ArticleResponse response = await _repository.getCategoryNewsBusiness(language);
    _subject.sink.add(response);
  }
      getCategoryNewsHealth(language) async {
    ArticleResponse response = await _repository.getCategoryNewsHealth(language);
    _subject.sink.add(response);
  }
        getCategoryNewsSports(language) async {
    ArticleResponse response = await _repository.getCategoryNewsSports(language);
    _subject.sink.add(response);
  }
        getCategoryNewsEntertainment(language) async {
    ArticleResponse response = await _repository.getCategoryNewsEntertainment(language);
    _subject.sink.add(response);
  }
        getCategoryNewsTechnology(language) async {
    ArticleResponse response = await _repository.getCategoryNewsTechnology(language);
    _subject.sink.add(response);
  }
        getCategoryNewsScience(language) async {
    ArticleResponse response = await _repository.getCategoryNewsScience(language);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
  
}
final getCategoryNewsClassBloc = GetCategoryNewsClassBloc();