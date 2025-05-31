// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ApiResponseToJson<T>(ApiResponse<T> instance) =>
    <String, dynamic>{
      'success': instance.success,
      if (instance.message case final value?) 'message': value,
      if (GenericJsonConverter<T?>().toJson(instance.data) case final value?)
        'data': value,
    };
