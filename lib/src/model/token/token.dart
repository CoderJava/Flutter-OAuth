import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  String scope;
  @JsonKey(ignore: true)
  String error;

  Token(this.accessToken, this.tokenType, this.refreshToken, this.expiresIn, this.scope);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Token.withError(this.error);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, tokenType: $tokenType, refreshToken: $refreshToken, expiresIn: $expiresIn, scope: $scope}';
  }
}
