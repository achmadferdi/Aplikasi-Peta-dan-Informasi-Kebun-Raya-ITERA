import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/config/config_session_manager.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_bloc.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_event.dart';
import 'package:ridikc_crud/data_katalog/bloc/data_katalog_state.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_apidata.dart';
import 'package:ridikc_crud/data_katalog/data_katalog_screen.dart';
import 'package:ridikc_crud/data_katalog/data_katalog_tampil.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_bloc.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_screen.dart';
import 'package:ridikc_crud/data_notifikasi/data_notifikasi_tambah.dart';
import 'package:ridikc_crud/home/ekatalog.dart';
import 'package:ridikc_crud/home/grid_dashboard.dart';
import 'package:ridikc_crud/home/home_app.dart';
import 'package:ridikc_crud/home/judul_ekatalog.dart';
import 'package:ridikc_crud/home/judul_informasi_layanan.dart';
import 'package:ridikc_crud/home/pencarian.dart';
import 'package:ridikc_crud/login/login_screen.dart';
import 'package:ridikc_crud/profil/profil_screen.dart';
import 'package:ridikc_crud/widgets/google_map_widget.dart';
import 'package:ridikc_crud/widgets/loading_widget.dart';
import 'package:ridikc_crud/widgets/my_app_bar.dart';
import 'package:ridikc_crud/widgets/slider_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cekLogin();
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(() {
        BlocProvider.of<DataLokasiBloc>(context).add(
          const FetchDataLokasi(
            DataFilter(),
          ),
        );
      }),
      drawerEnableOpenDragGesture: false,
      // drawer: const MyDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMapWidget(),
            loadingBuilder(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add),
            label: 'Panic',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.date_range),
          //   label: 'Jadwal',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.receipt_long),
          //   label: 'Transaksi',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share_location),
            label: 'Share Location',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Style.buttonBackgroundColor,
        onTap: ((value) {
          if (value == 0) {
            Navigator.of(context).pushNamed(ProfilScreen.routeName);
            return;
          }
          if (value == 1) {
            Navigator.of(context).pushNamed(
              DataNotifikasiTambahScreen.routeName,
              arguments: DataNotifikasiTambahArguments(
                data: DataNotifikasi(),
                judul: "Panic Button",
              ),
            );
            return;
          }
          if (value == 2) {
            shareCurrentLocation();
          }
        }),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  loadingBuilder() {
    return Center(
      child: BlocBuilder<DataLokasiBloc, DataLokasiState>(
        builder: (context, state) {
          if (state is DataLokasiLoading) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.red,
              color: Style.buttonBackgroundColor,
              strokeWidth: 8,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void cekLogin() async {
    if (!ConfigGlobal.login) return;
    final session = ConfigSessionManager.getInstance();
    final sudahLogin = await session.sudahLogin();
    if (sudahLogin) return;
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  Future<void> shareCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      String url = 'https://www.google.com/maps?q=$latitude,$longitude';

      // Bagikan URL lokasi saat ini
      await Share.share('Lokasi saya sekarang: $url');
    } catch (e) {
      print('Error sharing location: $e');
    }
  }
}

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}
