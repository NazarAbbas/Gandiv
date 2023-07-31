// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://devapi.gandivsamachar.com/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<NewsList>> getUsers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<NewsList>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => NewsList.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<SignupResponse> signupApi(signupRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(signupRequest.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SignupResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/accounts/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignupResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> loginApi(loginRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/accounts/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateNewsResponse> createNewsApi({
    token,
    heading,
    subHeading,
    newsContent,
    locationId,
    status,
    languageId,
    durationInMin,
    categoryId,
    multiPartFile,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (heading != null) {
      _data.fields.add(MapEntry(
        'Heading',
        heading,
      ));
    }
    if (subHeading != null) {
      _data.fields.add(MapEntry(
        'SubHeading',
        subHeading,
      ));
    }
    if (newsContent != null) {
      _data.fields.add(MapEntry(
        'newsContent',
        newsContent,
      ));
    }
    if (locationId != null) {
      _data.fields.add(MapEntry(
        'LocationId',
        locationId,
      ));
    }
    if (status != null) {
      _data.fields.add(MapEntry(
        'Status',
        status,
      ));
    }
    if (languageId != null) {
      _data.fields.add(MapEntry(
        'LanguageId',
        languageId,
      ));
    }
    if (durationInMin != null) {
      _data.fields.add(MapEntry(
        'DurationInMin',
        durationInMin,
      ));
    }
    if (categoryId != null) {
      _data.fields.add(MapEntry(
        'CategoryId',
        categoryId,
      ));
    }
    if (multiPartFile != null) {
      _data.files.addAll(multiPartFile.map((i) => MapEntry(
          'MediaFiles',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
          ))));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CreateNewsResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/news/create',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateNewsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyResponse> verifyApi(code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<VerifyResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/accounts/verify/${code}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyResponse> forgotPasswordApi(
    userName,
    password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'username': userName,
      r'password': password,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<VerifyResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/accounts/forgot-password',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AboutUsResponse> aboutusApi() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AboutUsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/Gandiv/aboutus',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AboutUsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EPaperResponse> ePaperApi() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EPaperResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/Gandiv/epaper',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EPaperResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CategoriesResponse> newsCategoryApi() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CategoriesResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/news/categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CategoriesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LocationsResponse> newsLocationsApi() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LocationsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/news/locations',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LocationsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NewsListResponse> newsListApi([
    categoryId,
    locationId,
    laguageId,
    pageSize,
    pageNumber,
    searchText,
  ]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'CategoryId': categoryId,
      r'LocationId': locationId,
      r'LanguageId': laguageId,
      r'PageSize': pageSize,
      r'PageNumber': pageNumber,
      r'SearchText': searchText,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<NewsListResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/news',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NewsListResponse.fromJson(_result.data!);
    return value;
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
}
