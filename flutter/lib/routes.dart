import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ridikc_crud/data_admin/bloc/data_admin_bloc.dart';
import 'package:ridikc_crud/data_admin/bloc/data_admin_hapus_bloc.dart';
import 'package:ridikc_crud/data_admin/bloc/data_admin_simpan_bloc.dart';
import 'package:ridikc_crud/data_admin/bloc/data_admin_ubah_bloc.dart';
import 'package:ridikc_crud/data_admin/data_admin_screen.dart';
import 'package:ridikc_crud/data_admin/data_admin_tambah.dart';
import 'package:ridikc_crud/data_admin/data_admin_ubah.dart';

import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_bloc.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_hapus_bloc.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_simpan_bloc.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_ubah_bloc.dart';
import 'package:ridikc_crud/data_lokasi/data_lokasi_screen.dart';
import 'package:ridikc_crud/data_lokasi/data_lokasi_tambah.dart';
import 'package:ridikc_crud/data_lokasi/data_lokasi_ubah.dart';

import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_hapus_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_simpan_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_ubah_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_screen.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_tambah.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_ubah.dart';

import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_hapus_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_simpan_bloc.dart';
import 'package:ridikc_crud/data_pengguna/bloc/data_pengguna_ubah_bloc.dart';
import 'package:ridikc_crud/data_pengguna/data_pengguna_screen.dart';
import 'package:ridikc_crud/data_pengguna/data_pengguna_tambah.dart';
import 'package:ridikc_crud/data_pengguna/data_pengguna_ubah.dart';

class Routes {
  static final datas = {
    DataAdminScreen.routeName: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<DataAdminBloc>(
              create: (BuildContext context) => DataAdminBloc(),
            ),
            BlocProvider<DataAdminHapusBloc>(
              create: (BuildContext context) => DataAdminHapusBloc(),
            ),
            BlocProvider<DataAdminUbahBloc>(
              create: (BuildContext context) => DataAdminUbahBloc(),
            ),
            BlocProvider<DataAdminSimpanBloc>(
              create: (BuildContext context) => DataAdminSimpanBloc(),
            ),
          ],
          child: const DataAdminScreen(),
        ),
    DataAdminTambahScreen.routeName: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<DataAdminBloc>(
              create: (BuildContext context) => DataAdminBloc(),
            ),
            BlocProvider<DataAdminHapusBloc>(
              create: (BuildContext context) => DataAdminHapusBloc(),
            ),
            BlocProvider<DataAdminUbahBloc>(
              create: (BuildContext context) => DataAdminUbahBloc(),
            ),
            BlocProvider<DataAdminSimpanBloc>(
              create: (BuildContext context) => DataAdminSimpanBloc(),
            ),
          ],
          child: const DataAdminTambahScreen(),
        ),
    DataAdminUbahScreen.routeName: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<DataAdminBloc>(
              create: (BuildContext context) => DataAdminBloc(),
            ),
            BlocProvider<DataAdminHapusBloc>(
              create: (BuildContext context) => DataAdminHapusBloc(),
            ),
            BlocProvider<DataAdminUbahBloc>(
              create: (BuildContext context) => DataAdminUbahBloc(),
            ),
            BlocProvider<DataAdminSimpanBloc>(
              create: (BuildContext context) => DataAdminSimpanBloc(),
            ),
          ],
          child: const DataAdminUbahScreen(),
        ),
    DataLokasiScreen.routeName: (context) => MultiBlocProvider(
          providers: [
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
          child: const DataLokasiScreen(),
        ),
    DataLokasiTambahScreen.routeName: (context) => MultiBlocProvider(
          providers: [
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
          child: const DataLokasiTambahScreen(),
        ),
    DataLokasiUbahScreen.routeName: (context) => MultiBlocProvider(
          providers: [
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
          child: const DataLokasiUbahScreen(),
        ),
    DataNotifikasiScreen.routeName: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<DataNotifikasiBloc>(
              create: (BuildContext context) => DataNotifikasiBloc(),
            ),
            BlocProvider<DataNotifikasiHapusBloc>(
              create: (BuildContext context) => DataNotifikasiHapusBloc(),
            ),
            BlocProvider<DataNotifikasiUbahBloc>(
              create: (BuildContext context) => DataNotifikasiUbahBloc(),
            ),
            BlocProvider<DataNotifikasiSimpanBloc>(
              create: (BuildContext context) => DataNotifikasiSimpanBloc(),
            ),
          ],
          child: const DataNotifikasiScreen(),
        ),
    DataNotifikasiTambahScreen.routeName: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<DataNotifikasiBloc>(
              create: (BuildContext context) => DataNotifikasiBloc(),
            ),
            BlocProvider<DataNotifikasiHapusBloc>(
              create: (BuildContext context) => DataNotifikasiHapusBloc(),
            ),
            BlocProvider<DataNotifikasiUbahBloc>(
              create: (BuildContext context) => DataNotifikasiUbahBloc(),
            ),
            BlocProvider<DataNotifikasiSimpanBloc>(
              create: (BuildContext context) => DataNotifikasiSimpanBloc(),
            ),
          ],
          child: const DataNotifikasiTambahScreen(),
        ),
    DataNotifikasiUbahScreen.routeName: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<DataNotifikasiBloc>(
              create: (BuildContext context) => DataNotifikasiBloc(),
            ),
            BlocProvider<DataNotifikasiHapusBloc>(
              create: (BuildContext context) => DataNotifikasiHapusBloc(),
            ),
            BlocProvider<DataNotifikasiUbahBloc>(
              create: (BuildContext context) => DataNotifikasiUbahBloc(),
            ),
            BlocProvider<DataNotifikasiSimpanBloc>(
              create: (BuildContext context) => DataNotifikasiSimpanBloc(),
            ),
          ],
          child: const DataNotifikasiUbahScreen(),
        ),
    DataPenggunaScreen.routeName: (context) => MultiBlocProvider(
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
          child: const DataPenggunaScreen(),
        ),
    DataPenggunaTambahScreen.routeName: (context) => MultiBlocProvider(
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
          child: const DataPenggunaTambahScreen(),
        ),
    DataPenggunaUbahScreen.routeName: (context) => MultiBlocProvider(
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
          child: const DataPenggunaUbahScreen(),
        ),
  };
}
