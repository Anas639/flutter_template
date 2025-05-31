import 'package:json_annotation/json_annotation.dart';
import 'package:server/dto.dart';

class GenericJsonConverter<T> extends JsonConverter<T?, Object?> {
  const GenericJsonConverter();
  @override
  T? fromJson(Object? json) {
    throw UnimplementedError();
  }

  @override
  Object? toJson(T? object) {
    if (object is ApiResponseData) {
      return object.toJson();
    }
    if (object is List<ApiResponseData>) {
      return object.map((e) => e.toJson()).toList();
    }
    return null;
  }
}
