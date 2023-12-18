import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/config/config_session_manager.dart';
import 'package:ridikc_crud/login/bloc/register_event.dart';
import 'package:ridikc_crud/login/bloc/register_state.dart';
import 'package:ridikc_crud/login/data/data_register.dart';
import 'package:ridikc_crud/login/data/register_api.dart';
import 'package:ridikc_crud/login/repo/repo_register_online.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RepoRegisterOnline repository = RepoRegisterOnline();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterPost>((event, emit) async {
      emit(RegisterLoading());
      try {
        DataRegister data = event.data;
        final RegisterApi response = await repository.register(data);
        if (response.status == 'success') {
          // await ConfigSessionManager.getInstance().setData();
          emit(RegisterSuccess(data: response));
        } else {
          emit(RegisterGagal(data: response));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(RegisterError());
      }
    });
  }
}
