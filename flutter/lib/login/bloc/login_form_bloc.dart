import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/login/bloc/login_form_event.dart';
import 'package:ridikc_crud/login/bloc/login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormWelcome()) {
    on<ShowWelcome>((event, emit) async {
      emit(LoginFormWelcome());
    });
    on<ShowLogin>((event, emit) async {
      emit(LoginFormLogin());
    });
    on<ShowRegister>((event, emit) async {
      emit(LoginFormRegister());
    });
  }
}
