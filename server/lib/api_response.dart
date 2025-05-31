import 'package:json_annotation/json_annotation.dart';
import 'package:server/generic_json_converter.dart';
import 'package:server/types.dart';

part 'api_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createFactory: false,
  explicitToJson: true,
)
class ApiResponse<T> {
  final bool success;
  final String? message;
  @GenericJsonConverter()
  final T? data;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
  });

  JSON toJson() => _$ApiResponseToJson(this);
}
