import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/response/article_response.dart';
import 'package:news_app/response/source_response.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  static String apiKey = 'b09f9c0cec7047b6aa51a56efe1b8f2f';

  Dio _dio = Dio();
  Response response;
  DioCacheManager _dioCacheManager;
  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadLinesUrl = "$mainUrl/top-headlines";
  var getEverythingUrl = "$mainUrl/everything";

  Future<ArticleResponse> getTopHeadlines(language) async {
    var params = {"apiKey": apiKey, "language": language};
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(
        getTopHeadLinesUrl,
        queryParameters: params,
        options: _cacheOptions,
      );
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getCategoryNews(category, language) async {
    var params = {"apiKey": apiKey, "category": category, "language": language};
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getCategoryNewsBusiness(language) async {
    var params = {
      "apiKey": apiKey,
      "category": "business",
      "language": language
    };
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getCategoryNewsHealth(language) async {
    var params = {"apiKey": apiKey, "category": "health", "language": language};
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getCategoryNewsSports(language) async {
    var params = {"apiKey": apiKey, "category": "sports", "language": language};
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getCategoryNewsEntertainment(language) async {
    var params = {
      "apiKey": apiKey,
      "category": "entertainment",
      "language": language
    };
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getCategoryNewsTechnology(language) async {
    var params = {
      "apiKey": apiKey,
      "category": "technology",
      "language": language
    };
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getCategoryNewsScience(language) async {
    var params = {
      "apiKey": apiKey,
      "category": "science",
      "language": language
    };
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getMySources(sourceName) async {
    var params = {
      "apiKey": apiKey,
      "sources": sourceName,
      "sortBy": "publishedAt"
    };
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(
        getTopHeadLinesUrl,
        queryParameters: params,
        options: _cacheOptions,
      );

      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError(
          "                                Please choose sources to view");
    }
  }

  Future<SourceResponse> getSource(language) async {
    var params = {
      "apiKey": apiKey,
      "language": language,
    };
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(
      Duration(days: 7),
      forceRefresh: true,
    );
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getSourcesUrl,
          queryParameters: params, options: _cacheOptions);
      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured : $error stackTrace : $stacktrace");
      return SourceResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {"apiKey": apiKey, "sources": sourceId};
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getEverythingUrl,
          queryParameters: params, options: _cacheOptions);

      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getHotNews(language) async {
    var params = {
      "apiKey": apiKey,
      "q": "apple",
      "language": "$language",
      "sortBy": "publishedAt"
    };
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getEverythingUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> search(String value) async {
    var params = {"apiKey": apiKey, "q": value, "sortBy": "popularity"};
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions =
        buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
    try {
      Response response = await _dio.get(getEverythingUrl,
          queryParameters: params, options: _cacheOptions);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }
}
