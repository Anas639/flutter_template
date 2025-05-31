import 'package:flutter_template/packages/core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_api_response.g.dart';

@JsonSerializable()
class BaseApiResponse {
  final bool success;
  final String? message;

  const BaseApiResponse({
    required this.success,
    required this.message,
  });

  factory BaseApiResponse.fromJson(JSON json) => _$BaseApiResponseFromJson(json);
  JSON toJson() => _$BaseApiResponseToJson(this);
}
