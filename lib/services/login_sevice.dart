import 'package:app_architecture_example/constants.dart';
import 'package:app_architecture_example/models/app_base_response.dart';
import 'package:app_architecture_example/models/login_model.dart';
import 'package:app_architecture_example/services/base_api_service.dart';
import 'package:app_architecture_example/utils/request_type.dart';

class LoginService {
  final ApiRequester _apiRequester;

  LoginService(this._apiRequester);

  Future<AppBaseResponse?> login(LoginModel loginModel) async {
    try {
      return await _apiRequester.makeRequest(type: RequestType.post, url: baseUrl, body: loginModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
