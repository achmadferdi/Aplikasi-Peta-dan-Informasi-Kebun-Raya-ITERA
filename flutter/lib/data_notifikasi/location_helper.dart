import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationHelper {
  static Future<void> saveLocation(double latitude, double longitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd')
        .format(currentDate); // Format tanggal sesuai kebutuhan Anda

    final savedLocations = prefs.getStringList(formattedDate) ?? [];

    savedLocations.add("$latitude,$longitude");
    await prefs.setStringList(formattedDate, savedLocations);

    final appDir = await getApplicationDocumentsDirectory();
    final locationFile = File('${appDir.path}/$formattedDate.json');

    if (locationFile.existsSync()) {
      final existingLocations = json.decode(await locationFile.readAsString());
      existingLocations[formattedDate] = savedLocations;
      await locationFile.writeAsString(json.encode(existingLocations));
    } else {
      final locations = {formattedDate: savedLocations};
      await locationFile.writeAsString(json.encode(locations));
    }
  }
}
