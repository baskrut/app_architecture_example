import 'package:app_architecture_example/models/app_base_response.dart';
import 'package:app_architecture_example/models/login_model.dart';
import 'package:app_architecture_example/services/base_api_service.dart';
import 'package:app_architecture_example/services/login_sevice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProvider with ChangeNotifier {
  final LoginService _loginService = LoginService(ApiRequester.instance);

  Future<AppBaseResponse?> login(LoginModel model) async {
    try {
      return await _loginService.login(model);
    } catch (e) {
      rethrow;
    }
  }
}

final authProvider = ChangeNotifierProvider.autoDispose<LoginProvider>((ref) {
  return LoginProvider();
});
