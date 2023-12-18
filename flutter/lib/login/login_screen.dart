import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/login/bloc/login_bloc.dart';
import 'package:ridikc_crud/login/bloc/login_form_bloc.dart';
import 'package:ridikc_crud/login/bloc/login_form_state.dart';
import 'package:ridikc_crud/login/bloc/register_bloc.dart';
import 'package:ridikc_crud/login/login_widget.dart';
import 'package:ridikc_crud/login/register_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(title: const Text('Login Screen')), */
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginFormBloc>(
            create: (BuildContext context) => LoginFormBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(),
          ),
          BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc(),
          )
        ],
        child: Stack(children: [
          // ListView(
          //   children: [
          //     Image.asset(
          //       "assets/background_login.png",
          //       fit: BoxFit.fitWidth,
          //     ),
          //   ],
          // ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/image-login.png',
                    height: 150,
                  ),
                  /* const SizedBox(height: 20), */
                  /* const Text( */
                  /*   ConfigGlobal.namaAplikasi, */
                  /*   style: TextStyle(fontSize: 20), */
                  /* ), */
                  const SizedBox(height: 20),
                  BlocBuilder<LoginFormBloc, LoginFormState>(
                      builder: (context, state) {
                    // if (state is LoginFormLogin) return const LoginWidget();
                    if (state is LoginFormRegister) {
                      return const RegisterWidget();
                    }
                    // return ConfigGlobal.register
                    //     ? const WelcomeWidget()
                    //     : const LoginWidget();
                    return const LoginWidget();
                  })
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
