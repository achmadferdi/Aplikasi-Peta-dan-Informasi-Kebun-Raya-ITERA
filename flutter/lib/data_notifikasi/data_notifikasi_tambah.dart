import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/config/config_session_manager.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_bloc.dart';
import 'package:ridikc_crud/enum/enum_widget.dart';
import 'package:ridikc_crud/enum/repo/enum_remote.dart';
import 'package:ridikc_crud/data_notifikasi/bloc/data_notifikasi_simpan_bloc.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi.dart';
import 'package:ridikc_crud/login/data/login_apidata.dart';
import 'package:ridikc_crud/widgets/loading_widget.dart';

class DataNotifikasiTambahScreen extends StatefulWidget {
  static const routeName = "data_notifikasi/tambah";
  const DataNotifikasiTambahScreen({super.key});

  @override
  State<DataNotifikasiTambahScreen> createState() =>
      _DataNotifikasiTambahScreenState();
}

class _DataNotifikasiTambahScreenState
    extends State<DataNotifikasiTambahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataFilter filter = const DataFilter();

  DataNotifikasiTambahArguments? screenArgument;

  DataNotifikasi form = DataNotifikasi();

  var idNotifikasiController = TextEditingController();
  var notifikasiController = TextEditingController();
  var namaController = TextEditingController();
  var statusController = TextEditingController();
  List<String> status = [];

  LoginApiData? session;

  fetchStatus() async {
    var data = await enumRemote.getData('data_notifikasi', 'status');
    status = data.result;
  }

  @override
  void initState() {
    super.initState();

    idNotifikasiController.addListener(() {
      form.idNotifikasi = idNotifikasiController.text;
    });

    notifikasiController.addListener(() {
      form.notifikasi = notifikasiController.text;
    });

    namaController.addListener(() {
      form.nama = namaController.text;
    });

    statusController.addListener(() {
      form.status = statusController.text;
    });

    fetchStatus();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenArgument = ModalRoute.of(context)!.settings.arguments
          as DataNotifikasiTambahArguments;

      if (screenArgument != null) {}

      setState(() {});
    });

    getSession();
  }

  void getSession() async {
    session = await ConfigSessionManager.getInstance().getData();
    if (session == null) {
      return;
    }
    filter = DataFilter(idPeserta: "${session?.id}");
    fetchData();
  }

  void fetchData() async {
    BlocProvider.of<DataNotifikasiBloc>(context).add(
      FetchDataNotifikasi(filter),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<DataNotifikasiSimpanBloc>(context),
      listener: ((context, state) {
        if (state is DataNotifikasiSimpanLoadSuccess) {
          const snackBar = SnackBar(
            content: Text('Data berhasil disimpan'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        }
        if (state is DataNotifikasiSimpanLoadFailure) {
          const snackBar = SnackBar(
            content: Text('Data gagal disimpan'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      child: BlocBuilder<DataNotifikasiSimpanBloc, DataNotifikasiSimpanState>(
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(title: Text(screenArgument?.judul ?? "")),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: PanicButtonScreen(
                onPressed: (value) {},
              ),
            ),
          );
        },
      ),
    );
  }

  formInput(state) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Silahkan lengkapi form',
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            border: OutlineInputBorder(),
            labelText: 'Id Notifikasi',
          ),
          controller: idNotifikasiController,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            border: OutlineInputBorder(),
            labelText: 'Notifikasi',
          ),
          controller: notifikasiController,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            border: OutlineInputBorder(),
            labelText: 'Nama',
          ),
          controller: namaController,
        ),
        const SizedBox(height: 15),
        TextFormField(
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pilih Status'),
                  content: EnumWidget(
                    items: status,
                    onChange: (String value) {
                      statusController.text = value;
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          controller: statusController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: OutlineInputBorder(),
            labelText: 'Status',
          ),
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              primary: Style.buttonBackgroundColor,
            ),
            onPressed: () {
              BlocProvider.of<DataNotifikasiSimpanBloc>(context)
                  .add(FetchDataNotifikasiSimpan(form));
            },
            child: state is DataNotifikasiSimpanLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.save),
                      SizedBox(width: 5),
                      Text(
                        "Simpan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    idNotifikasiController.dispose();
    notifikasiController.dispose();
    namaController.dispose();
    statusController.dispose();

    super.dispose();
  }
}

class DataNotifikasiTambahArguments {
  final DataNotifikasi data;
  final String judul;

  DataNotifikasiTambahArguments({
    required this.data,
    required this.judul,
  });
}

class PanicButtonScreen extends StatefulWidget {
  final Function(bool value) onPressed;

  const PanicButtonScreen({super.key, required this.onPressed});

  @override
  _PanicButtonScreenState createState() => _PanicButtonScreenState();
}

class _PanicButtonScreenState extends State<PanicButtonScreen>
    with TickerProviderStateMixin {
  bool isPressed = false;
  bool showInfo = false;
  late AnimationController _animationController;

  StreamSubscription<LocationData>? locationSubscription;

  double? latitude;

  double? longitude;

  void startLocationUpdates() {
    final location = Location();
    locationSubscription = location.onLocationChanged.listen((locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          latitude = locationData.latitude!;
          longitude = locationData.longitude!;
        });
      }
    });
  }

  void configureLocationService() {
    final location = Location();

    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000, // Update interval in milliseconds
    );
  }

  Future<void> requestLocationPermission() async {
    final location = Location();
    final hasPermission = await location.requestPermission();

    if (hasPermission == PermissionStatus.granted) {
      startLocationUpdates();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Izin: lokasi gagal.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void stopLocationUpdates() {
    locationSubscription?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {}); // Memicu setState saat animasi berubah
      });
    _animationController.repeat(reverse: true);
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final color = isPressed
            ? Colors.red.withOpacity(_animationController.value)
            : Colors.blue;
        return ElevatedButton(
          onPressed: () async {
            setState(() {
              isPressed = !isPressed;
              showInfo = !showInfo;

              widget.onPressed(isPressed);
            });

            LoginApiData? session =
                await ConfigSessionManager.getInstance().getData();
            if (session == null) {
              return;
            }

            DataNotifikasi form = DataNotifikasi(
              notifikasi:
                  "Panic button <a target='_blank' href='https://www.google.com/maps/place/$latitude,$longitude'>lokasi</a>",
              nama: "${session.id}",
            );

            if (mounted) {
              BlocProvider.of<DataNotifikasiSimpanBloc>(context).add(
                FetchDataNotifikasiSimpan(form),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            primary: color,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(100.0),
            // ),
            elevation: 5,
            padding: const EdgeInsets.all(20.0),
            minimumSize: const Size(200, 200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LocationInfoWidget(
                latitude: latitude,
                longitude: longitude,
              ),
              const SizedBox(height: 16.0),
              const Icon(
                Icons.warning,
                size: 48.0,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                isPressed ? 'Panic!' : 'Panic button, Press Me!',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              if (showInfo)
                const Text(
                  'Petugas akan datang dalam beberapa menit. Tetap di posisi anda.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              BlocBuilder<DataNotifikasiBloc, DataNotifikasiState>(
                builder: (context, state) {
                  if (state is DataNotifikasiLoadSuccess) {
                    return const LoadingWidget();
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    stopLocationUpdates();
    super.dispose();
  }
}

class LocationInfoWidget extends StatelessWidget {
  final double? latitude;
  final double? longitude;

  LocationInfoWidget({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 30.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Location Coordinates',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                SizedBox(width: 8.0),
                Text(
                  'Latitude: $latitude',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                SizedBox(width: 8.0),
                Text(
                  'Longitude: $longitude',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
