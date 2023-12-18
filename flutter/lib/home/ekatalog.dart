import 'package:flutter/material.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_apidata.dart';
import 'package:ridikc_crud/data_katalog/data_katalog_detail.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';

class Ekatalog extends StatefulWidget {
  DataLokasiApiData data;

  Ekatalog({super.key, required this.data});

  @override
  State<Ekatalog> createState() => _EkatalogState();
}

class _EkatalogState extends State<Ekatalog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.48,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DataKatalogDetail.routeName,
                arguments: widget.data);
          },
          child: Stack(children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.foto1}",
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/image-not-available.jpg",
                        width: double.infinity,
                        height: 140,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                  child: Text(
                    "${widget.data.nama}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                  child: Text(
                    "${widget.data.nama}",
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.only(top: 3, bottom: 3, left: 9, right: 9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Style.buttonBackgroundColor,
                ),
                child: Text(
                  "${widget.data.deskripsi}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
