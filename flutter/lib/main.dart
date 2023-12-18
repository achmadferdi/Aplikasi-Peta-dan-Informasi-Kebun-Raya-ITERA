import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_bloc.dart';
import 'package:ridikc_crud/data_katalog/data_katalog_screen.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_bloc.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_hapus_bloc.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_simpan_bloc.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_ubah_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_hapus_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_simpan_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_ubah_bloc.dart';
import 'package:ridikc_crud/home/home_screen.dart';
import 'package:ridikc_crud/login/login_screen.dart';
import 'package:ridikc_crud/profil/profil_screen.dart';
import 'package:ridikc_crud/frame/frame_screen.dart';
import 'package:ridikc_crud/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peta Kebun Raya ITERA',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      routes: {
        ProfilScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataPenggunaBloc>(
                  create: (BuildContext context) => DataPenggunaBloc(),
                ),
                BlocProvider<DataPenggunaHapusBloc>(
                  create: (BuildContext context) => DataPenggunaHapusBloc(),
                ),
                BlocProvider<DataPenggunaUbahBloc>(
                  create: (BuildContext context) => DataPenggunaUbahBloc(),
                ),
                BlocProvider<DataPenggunaSimpanBloc>(
                  create: (BuildContext context) => DataPenggunaSimpanBloc(),
                ),
              ],
              child: const ProfilScreen(),
            ),
        HomeScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataKatalogBloc>(
                  create: (BuildContext context) => DataKatalogBloc(),
                ),
                BlocProvider<DataLokasiBloc>(
                  create: (BuildContext context) => DataLokasiBloc(),
                ),
                BlocProvider<DataLokasiHapusBloc>(
                  create: (BuildContext context) => DataLokasiHapusBloc(),
                ),
                BlocProvider<DataLokasiUbahBloc>(
                  create: (BuildContext context) => DataLokasiUbahBloc(),
                ),
                BlocProvider<DataLokasiSimpanBloc>(
                  create: (BuildContext context) => DataLokasiSimpanBloc(),
                ),
              ],
              child: const HomeScreen(),
            ),
        DataKatalogScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataKatalogBloc>(
                  create: (BuildContext context) => DataKatalogBloc(),
                ),
                BlocProvider<DataLokasiBloc>(
                  create: (BuildContext context) => DataLokasiBloc(),
                ),
              ],
              child: const DataKatalogScreen(),
            ),
        LoginScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataPenggunaBloc>(
                  create: (BuildContext context) => DataPenggunaBloc(),
                ),
                BlocProvider<DataPenggunaHapusBloc>(
                  create: (BuildContext context) => DataPenggunaHapusBloc(),
                ),
                BlocProvider<DataPenggunaUbahBloc>(
                  create: (BuildContext context) => DataPenggunaUbahBloc(),
                ),
                BlocProvider<DataPenggunaSimpanBloc>(
                  create: (BuildContext context) => DataPenggunaSimpanBloc(),
                ),
              ],
              child: const LoginScreen(),
            ),
        ...Routes.datas
      },
      theme: ThemeData(
        primaryColor: Style.buttonBackgroundColor,
        appBarTheme: const AppBarTheme(color: Style.buttonBackgroundColor),
      ),
    );
  }
}
