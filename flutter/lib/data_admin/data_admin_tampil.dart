import 'package:flutter/material.dart';
import 'package:ridikc_crud/data_admin/data/data_admin_apidata.dart';
import 'package:ridikc_crud/config/config_global.dart';

const bool showImageCard = true;

class DataAdminTampil extends StatefulWidget {
  final DataAdminApiData data;
  final Function(DataAdminApiData value) onTapEdit;
  final Function(DataAdminApiData value) onTapHapus;

  const DataAdminTampil({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onTapHapus,
  });

  @override
  State<DataAdminTampil> createState() =>
      _DataAdminTampilState();
}

class _DataAdminTampilState extends State<DataAdminTampil> {
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
                  "#${widget.data.idAdmin}",
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
              "Id Admin : ${widget.data.idAdmin}",
              style: const TextStyle(fontSize: 16),
            ),
*/

	
            Text(
              "Nama : ${widget.data.nama}",
              style: const TextStyle(fontSize: 16),
            ),

	
            Text(
              "Username : ${widget.data.username}",
              style: const TextStyle(fontSize: 16),
            ),

	
            Text(
              "Password : ${widget.data.password}",
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
