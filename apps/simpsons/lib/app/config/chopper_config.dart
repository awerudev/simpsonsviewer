import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';
import 'package:pretty_chopper_logger/pretty_chopper_logger.dart';
import 'package:shared/app/helpers/json_serializable_converter.dart';
import 'package:shared/features/viewer/data/model/post.dto.dart';
import 'package:shared/features/viewer/data/service/post_service.dart';
import 'package:simpsons/app/config/app_config.dart';

final class ChopperConfig {
  static Uri get baseUrl => Uri.parse(AppConfig.baseApiUrl);

  static List<ChopperService> get services => <ChopperService>[
        PostService.create(),
      ];

  static JsonSerializableConverter get converter =>
      const JsonSerializableConverter(
        <Type, dynamic Function(Map<String, dynamic>)>{
          PostDTO: PostDTO.fromJson,
        },
      );

  static List<dynamic> get interceptors => <dynamic>[
        (Request request) async {
          final Map<String, String> headers = <String, String>{}
            ..addEntries(request.headers.entries)
            ..putIfAbsent('Accept', () => 'application/json')
            ..putIfAbsent('Content-type', () => 'application/json');

          return request.copyWith(headers: headers);
        },
        if (kDebugMode) PrettyChopperLogger(),
        if (kDebugMode) CurlInterceptor(),
      ];

  static ChopperClient get client => ChopperClient(
        baseUrl: ChopperConfig.baseUrl,
        client: !kIsWeb
            ? IOClient(
                HttpClient()
                  ..badCertificateCallback =
                      (X509Certificate cert, String host, int port) => true,
              )
            : null,
        interceptors: ChopperConfig.interceptors,
        converter: ChopperConfig.converter,
        services: ChopperConfig.services,
      );
}
