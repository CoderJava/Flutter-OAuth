import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class Register {
  int age;
  String username;
  String password;

  Register(this.age, this.username, this.password);

  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);

  @override
  String toString() {
    return 'Register{age: $age, username: $username, password: $password}';
  }
}
