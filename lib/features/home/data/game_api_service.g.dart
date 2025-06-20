// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _GameApiService implements GameApiService {
  _GameApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.rawg.io/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GameListResponse> getGames(
    String apiKey,
    int page,
    int pageSize,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'page': page,
      r'page_size': pageSize,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GameListResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'games',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GameListResponse _value;
    try {
      _value = GameListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      rethrow;
    }
    return _value;
  }

  @override
  Future<GameListResponse> searchGames(
    String apiKey,
    String query,
    int page,
    int pageSize,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'search': query,
      r'page': page,
      r'page_size': pageSize,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GameListResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'games',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GameListResponse _value;
    try {
      _value = GameListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      rethrow;
    }
    return _value;
  }

  @override
  Future<GameListResponse> getGamesWithParams(
    String apiKey,
    int page,
    int pageSize,
    int? platformId,
    int? genreId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'page': page,
      r'page_size': pageSize,
      r'platforms': platformId,
      r'genres': genreId,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GameListResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'games',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GameListResponse _value;
    try {
      _value = GameListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenreListResponse> getGenres(String apiKey) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'key': apiKey};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GenreListResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'genres',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenreListResponse _value;
    try {
      _value = GenreListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      rethrow;
    }
    return _value;
  }

  @override
  Future<PlatformListResponse> getPlatforms(String apiKey) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'key': apiKey};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PlatformListResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'platforms',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late PlatformListResponse _value;
    try {
      _value = PlatformListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
