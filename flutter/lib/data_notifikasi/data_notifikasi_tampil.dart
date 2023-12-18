import 'package:flutter/material.dart';
import 'package:ridikc_crud/data_notifikasi/data/data_notifikasi_apidata.dart';
import 'package:ridikc_crud/config/config_global.dart';

const bool showImageCard = true;

class DataNotifikasiTampil extends StatefulWidget {
  final DataNotifikasiApiData data;
  final Function(DataNotifikasiApiData value) onTapEdit;
  final Function(DataNotifikasiApiData value) onTapHapus;

  const DataNotifikasiTampil({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onTapHapus,
  });

  @override
  State<DataNotifikasiTampil> createState() =>
      _DataNotifikasiTampilState();
}

class _DataNotifikasiTampilState extends State<DataNotifikasiTampil> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showImageCard)
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.asset(
                  "assets/background.png",
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
              
                Text(
                  "#${widget.data.idNotifikasi}",
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),
                PopupMenuButton<int>(
                  padding: const EdgeInsets.all(0),
                  onSelected: (item) {
                    if (item == 0) {
                      widget.onTapEdit(widget.data);
                      return;
                    }
                    if (item == 1) {
                      widget.onTapHapus(widget.data);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text('Edit')),
                    const PopupMenuItem<int>(value: 1, child: Text('Hapus')),
                  ],
                ),
              ],
            ),
            	
/*            Text(
              "Id Notifikasi : ${widget.data.idNotifikasi}",
              style: const TextStyle(fontSize: 16),
            ),
*/

	
            Text(
              "Notifikasi : ${widget.data.notifikasi}",
              style: const TextStyle(fontSize: 16),
            ),

	
            Text(
              "Nama : ${widget.data.nama}",
              style: const TextStyle(fontSize: 16),
            ),

	
            Text(
              "Status : ${widget.data.status}",
              style: const TextStyle(fontSize: 16),
            ),


/* 
            Text(
              "Hapalan: ${widget.data.hapalan}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Keterangan : ${widget.data.keterangan}",
              style: const TextStyle(fontSize: 16),
            ), */
          ],
        ),
      ),
    );
  }
}
