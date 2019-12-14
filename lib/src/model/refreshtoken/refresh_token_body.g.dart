// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenBody _$RefreshTokenBodyFromJson(Map<String, dynamic> json) {
  return RefreshTokenBody(
    json['grant_type'] as String,
    json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$RefreshTokenBodyToJson(RefreshTokenBody instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'refresh_token': instance.refreshToken,
    };
