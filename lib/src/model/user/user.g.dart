// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['diagnostic'] == null
        ? null
        : Diagnostic.fromJson(json['diagnostic'] as Map<String, dynamic>),
    (json['users'] as List)
        ?.map((e) =>
            e == null ? null : ItemUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'diagnostic': instance.diagnostic,
      'users': instance.users,
    };

ItemUser _$ItemUserFromJson(Map<String, dynamic> json) {
  return ItemUser(
    json['username'] as String,
    json['age'] as int,
  );
}

Map<String, dynamic> _$ItemUserToJson(ItemUser instance) => <String, dynamic>{
      'username': instance.username,
      'age': instance.age,
    };
