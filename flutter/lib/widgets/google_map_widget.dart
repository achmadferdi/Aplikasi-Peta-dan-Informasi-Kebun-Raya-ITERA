import 'dart:async';
import 'package:geojson/geojson.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:location/location.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data/data_filter.dart';
import 'package:ridikc_crud/data_lokasi/bloc/data_lokasi_bloc.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';
import 'package:ridikc_crud/data_lokasi/data_lokasi_tampil.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};

  GoogleMapController? mapController;

  CameraPosition _mapInitialPosition = CameraPosition(
    target: LatLng(-1.613708340159109, 103.62581739486991),
    zoom: 15.0,
  );

  List<LatLng> polylines = [];

  @override
  void initState() {
    BlocProvider.of<DataLokasiBloc>(context).add(
      const FetchDataLokasi(
        DataFilter(),
      ),
    );

    _requestLocationPermission();

    //TODO: harus nya di pindahkan ke bloc
    _fetchAndParseGeoJSON();

    final DateTime now = DateTime.now();
    final String date = "${now.year}-${now.month}-${now.day}";

    loadLocationHistory(date);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DataLokasiBloc, DataLokasiState>(
          listener: (context, state) {
            if (state is DataLokasiLoadSuccess) {
              if (state.data.result.isNotEmpty) {
                List<DataLokasiApiData> datas = state.data.result;

                Set<Marker> _tmpMarkers = {};

                _markers.clear();
                for (var data in datas) {
                  if (data.getLatLng() != null) {
                    var _marker = _addMarker(
                      data,
                      "${data.nama}",
                      () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  DataLokasiTampil(
                                    data: data,
                                    onTapEdit: (value) {},
                                    onTapHapus: (value) {},
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                    _tmpMarkers.add(_marker);
                  }
                }

                setState(() {
                  _markers = _tmpMarkers;
                });
              }
            }
          },
        ),
      ],
      child: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: _mapInitialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              // _showUserLocation();
              mapController = controller;

              // _addMarker(
              //   LatLng(-1.612708340159109, 103.62581739486991),
              //   'Gajah',
              // );
              // _addMarker(
              //   LatLng(-1.614708340159109, 103.62581739486991),
              //   'Harimau',
              // );

              _moveCamera();
            },
            markers: _markers,
            polygons: polygons,
            polylines: Set<Polyline>.of(
              <Polyline>[
                Polyline(
                    polylineId: PolylineId("polyline"),
                    color: Colors.blue,
                    points: polylines,
                    width: 2),
              ],
            ),
          ),
          // Positioned(
          //   right: 9,
          //   top: 9,
          //   child: FloatingActionButton(
          //     onPressed: () {},
          //     child: const Icon(
          //       Icons.more_vert,
          //       color: Colors.white,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Location location = Location();

  Future<void> _requestLocationPermission() async {
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

  String geoJsonUrl = "${ConfigGlobal.baseUrl}/map.geojson";

  List<LatLng> points = [];
  Set<Polygon> polygons = {};

  Future<void> _fetchAndParseGeoJSON() async {
    final geo = GeoJson();
    // geo.processedPolygons.listen((GeoJsonPolygon polygon) {
    //   polygon.geoSeries.length;
    // });
    final response = await http.get(Uri.parse(geoJsonUrl));

    if (response.statusCode == 200) {
      try {
        await geo.parse(response.body, verbose: true);
        points.clear();
        for (GeoJsonPolygon polygon in geo.polygons) {
          for (var series in polygon.geoSeries) {
            //TODO: harus nya per series itu satu polygon jadi hanya bisa satu polygon
            for (var point in series.geoPoints) {
              var ltlng = LatLng(point.latitude, point.longitude);
              points.add(ltlng);
            }
          }
        }
        List<Polygon> addPolygon = [
          Polygon(
            polygonId: PolygonId('India'),
            points: points,
            consumeTapEvents: true,
            strokeColor: Color.fromARGB(255, 158, 158, 158),
            strokeWidth: 1,
            fillColor: Color.fromARGB(152, 158, 158, 158),
          ),
        ];

        var center = calculatePolygonCenter(Polygon(
          polygonId: PolygonId('India'),
          points: points,
          consumeTapEvents: true,
          strokeColor: Color.fromARGB(255, 158, 158, 158),
          strokeWidth: 1,
          fillColor: Color.fromARGB(152, 158, 158, 158),
        ));

        if (center != null) {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: center,
                zoom: 15.0,
              ),
            ),
          );
        }

        Set<Polygon> _polygons = {};

        _polygons.addAll(addPolygon);

        setState(() {
          polygons = _polygons;
        });

        if (points.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Geojson: Polygon kosong!'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      } catch (e) {
        debugPrint('Error: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Geo map json invalid'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('HTTP Error: ${response.statusCode}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  LatLng? calculatePolygonCenter(Polygon polygon) {
    double totalLatitude = 0.0;
    double totalLongitude = 0.0;
    int vertexCount = 0;

    for (var point in polygon.points) {
      totalLatitude += point.latitude;
      totalLongitude += point.longitude;
      vertexCount++;
    }

    if (vertexCount > 0) {
      double centerLatitude = totalLatitude / vertexCount;
      double centerLongitude = totalLongitude / vertexCount;
      return LatLng(centerLatitude, centerLongitude);
    } else {
      return null;
    }
  }

  Future<void> _showUserLocation() async {
    final currentLocation = await location.getLocation();
    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentLocation.latitude!,
              currentLocation.longitude!,
            ),
            zoom: 15,
          ),
        ),
      );
    }
  }

  CameraPosition _anotherPosition = CameraPosition(
    target: LatLng(-1.614708340159109, 103.62581739486991),
    zoom: 15.0,
  );

  Future<void> _moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_anotherPosition));
  }

  Marker _addMarker(DataLokasiApiData data, String title, VoidCallback onTap) {
    var position = data.getLatLng()!;
    return Marker(
      markerId: MarkerId(data.getIdHapus()),
      position: position,
      infoWindow: InfoWindow(
        title: title,
      ),
      onTap: onTap,
    );
  }

  List<Map<String, dynamic>> locationHistory = [];

  void saveLocation(double latitude, double longitude) async {
    if (!loadHistoryDone) {
      return;
    }

    final DateTime now = DateTime.now();
    final String formattedDate = "${now.year}-${now.month}-${now.day}";
    final Map<String, dynamic> locationData = {
      'date': formattedDate,
      'latitude': latitude,
      'longitude': longitude,
    };

    locationHistory.add(locationData);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$formattedDate.json');

    await file.writeAsString(json.encode(locationHistory));
    setState(() {});

    List<LatLng> history = locationHistory.map((locationData) {
      var latitude = locationData['latitude'] as double;
      var longitude = locationData['longitude'] as double;
      return LatLng(latitude, longitude);
    }).toList();

    setState(() {
      polylines = filterPoints(history);
    });
  }

  void loadAllLocationHistory() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = directory.listSync();

    for (final file in files) {
      if (file is File && file.path.endsWith('.json')) {
        final String fileContents = await file.readAsString();
        final Map<String, dynamic> locationData =
            json.decode(fileContents) as Map<String, dynamic>;

        var latitude = locationData['latitude'];
        var longitude = locationData['longitude'];

        locationHistory.add(locationData);
      }
    }

    setState(() {});
  }

  bool loadHistoryDone = false;

  void loadLocationHistory(String date) async {
    final directory = await getApplicationDocumentsDirectory();
    final String fileName = '$date.json';
    final File file = File('${directory.path}/$fileName');

    if (await file.exists()) {
      final String fileContents = await file.readAsString();
      try {
        final List<dynamic> jsonData = json.decode(fileContents);

        jsonData.map((item) {
          final double latitude = item['latitude'] as double;
          final double longitude = item['longitude'] as double;
          final String formattedDate = item['date'] as String;

          final Map<String, dynamic> locationData = {
            'date': formattedDate,
            'latitude': latitude,
            'longitude': longitude,
          };

          locationHistory.add(locationData);
        }).toList();
      } catch (e) {
        debugPrint("loadLocationHistory ${e.toString()}");
      }

      loadHistoryDone = true;
    }
  }

// List<LatLng> history = locationHistory.map((locationData) {
//   var latitude = locationData['latitude'] as double;
//   var longitude = locationData['longitude'] as double;
//   debugPrint(
//     "loadLocationHistory koordinat :: ${locationData['latitude']} ${locationData['longitude']}",
//   );
//   return LatLng(latitude, longitude);
// }).toList();

  StreamSubscription<LocationData>? locationSubscription;

  void startLocationUpdates() {
    final location = Location();
    location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 1);
    locationSubscription = location.onLocationChanged.listen((locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        saveLocation(locationData.latitude!, locationData.longitude!);
      }
    });
  }

  List<LatLng> filterPoints(List<LatLng> points) {
    List<LatLng> filteredPoints = [];
    double minDistanceThreshold = 10;

    for (int i = 0; i < points.length; i++) {
      if (filteredPoints.isEmpty) {
        filteredPoints.add(points[i]);
      } else {
        double distance = calculateDistance(filteredPoints.last, points[i]);
        if (distance > minDistanceThreshold) {
          filteredPoints.add(points[i]);
        }
      }
    }

    return filteredPoints;
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    double earthRadius = 6371000; // Radius Bumi dalam meter
    double lat1 = point1.latitude * (3.141592653589793 / 180.0);
    double lon1 = point1.longitude * (3.141592653589793 / 180.0);
    double lat2 = point2.latitude * (3.141592653589793 / 180.0);
    double lon2 = point2.longitude * (3.141592653589793 / 180.0);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }
}
