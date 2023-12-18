import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_bloc.dart';

class MyAppBar extends AppBar {
  final Function onPressed;

  MyAppBar(this.onPressed, {super.key})
      : super(
          // elevation: 0.0,
          // centerTitle: true,
          title: const Text(ConfigGlobal.namaAplikasi),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                onPressed();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        );
}
