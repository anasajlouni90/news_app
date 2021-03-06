import 'package:news_app/response/news_repository.dart';
import 'package:news_app/response/source_response.dart';

import 'package:rxdart/rxdart.dart';

class GetSourcesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<SourceResponse> _subject =
      BehaviorSubject<SourceResponse>();

  getSources(String language) async {
    SourceResponse response = await _repository.getSource(language);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SourceResponse> get subject => _subject;
  
}
final getSourcesBloc = GetSourcesBloc();