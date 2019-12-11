import 'package:flutter_sample_oauth/src/api/api_auth_provider.dart';
import 'package:flutter_sample_oauth/src/model/diagnostic/diagnostic.dart';
import 'package:flutter_sample_oauth/src/model/login/login_body.dart';
import 'package:flutter_sample_oauth/src/model/refreshtoken/refresh_token_body.dart';
import 'package:flutter_sample_oauth/src/model/register/register.dart';
import 'package:flutter_sample_oauth/src/model/token/token.dart';
import 'package:flutter_sample_oauth/src/model/user/user.dart';

class ApiAuthRepository {
  final ApiAuthProvider _apiAuthProvider = ApiAuthProvider();

  Future<Diagnostic> postRegisterUser(Register register) => _apiAuthProvider.registerUser(register);

  Future<Token> postLoginUser(LoginBody loginBody) => _apiAuthProvider.loginUser(loginBody);

  Future<Token> postRefreshAuth(RefreshTokenBody refreshTokenBody) => _apiAuthProvider.refreshAuth(refreshTokenBody);

  Future<User> fetchAllUsers() => _apiAuthProvider.getAllUsers();
}
