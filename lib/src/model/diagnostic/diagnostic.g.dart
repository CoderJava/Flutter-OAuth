// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnostic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnostic _$DiagnosticFromJson(Map<String, dynamic> json) {
  return Diagnostic(
    json['status'] as int,
    json['message'] as String,
    json['unix_timestamp'] as int,
  );
}

Map<String, dynamic> _$DiagnosticToJson(Diagnostic instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'unix_timestamp': instance.unixTimestamp,
    };
