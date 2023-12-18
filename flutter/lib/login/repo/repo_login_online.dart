import 'package:ridikc_crud/login/data/data_login.dart';
import 'package:ridikc_crud/login/data/login_api.dart';
import 'package:ridikc_crud/login/repo/login_apiservice.dart';
import 'package:ridikc_crud/login/repo/repo_login_interface.dart';

class RepoLoginOnline extends RepoLoginInterface {
  final LoginApiService _serviceApi = LoginApiService();

  @override
  Future<LoginApi> login(DataLogin data) {
    return _serviceApi.login(data);
  }
}
