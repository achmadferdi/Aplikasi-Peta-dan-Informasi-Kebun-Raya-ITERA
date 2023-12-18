import 'package:ridikc_crud/login/data/data_login.dart';
import 'package:ridikc_crud/login/data/login_api.dart';

abstract class RepoLoginInterface {
  Future<LoginApi> login(DataLogin data);
}
