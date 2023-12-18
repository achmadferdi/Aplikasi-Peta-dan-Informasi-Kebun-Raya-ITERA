import 'package:flutter/material.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_apidata.dart';
import 'package:ridikc_crud/data_katalog/data_katalog_detail.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';

class DataKatalogTampil extends StatefulWidget {
  DataLokasiApiData data;
  DataKatalogTampil({super.key, required this.data});

  @override
  State<DataKatalogTampil> createState() => _DataKatalogTampilState();
}

class _DataKatalogTampilState extends State<DataKatalogTampil> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.foto1}",
            width: width * 0.3,
            height: width * 0.3,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/image-not-available.jpg",
                width: width * 0.3,
                height: width * 0.3,
                fit: BoxFit.cover,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(9),
            child: SizedBox(
                width: width - (width * 0.3) - 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      "${widget.data.nama}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    /* const SizedBox(height: 6),
                    Text(
                      ConfigGlobal.formatRupiah(widget.data.harga),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Style.buttonBackgroundColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text("Sisa ${widget.data.sisa} Peserta"),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, DataKatalogDetail.routeName,
                                arguments: widget.data);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: Style.buttonBackgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text("Detail"),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                        )
                      ],
                    ) */
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
