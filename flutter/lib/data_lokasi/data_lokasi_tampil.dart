import 'package:flutter/material.dart';
import 'package:ridikc_crud/data_lokasi/data/data_lokasi_apidata.dart';
import 'package:ridikc_crud/config/config_global.dart';

const bool showImageCard = true;

class DataLokasiTampil extends StatefulWidget {
  final DataLokasiApiData data;
  final Function(DataLokasiApiData value) onTapEdit;
  final Function(DataLokasiApiData value) onTapHapus;

  const DataLokasiTampil({
    super.key,
    required this.data,
    required this.onTapEdit,
    required this.onTapHapus,
  });

  @override
  State<DataLokasiTampil> createState() => _DataLokasiTampilState();
}

class _DataLokasiTampilState extends State<DataLokasiTampil> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (showImageCard)
            //   SizedBox(
            //     width: double.infinity,
            //     child: Image.network(
            //       "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.foto1}",
            //     ),
            //   ),
            ImageSlider(
              imageUrls: [
                "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.foto1}",
                "${ConfigGlobal.baseUrl}/admin/upload/${widget.data.foto2}",
              ],
            ),
            const SizedBox(height: 9),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${widget.data.nama}",
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const Spacer(),
                // PopupMenuButton<int>(
                //   padding: const EdgeInsets.all(0),
                //   onSelected: (item) {
                //     if (item == 0) {
                //       widget.onTapEdit(widget.data);
                //       return;
                //     }
                //     if (item == 1) {
                //       widget.onTapHapus(widget.data);
                //     }
                //   },
                //   itemBuilder: (context) => [
                //     const PopupMenuItem<int>(value: 0, child: Text('Edit')),
                //     const PopupMenuItem<int>(value: 1, child: Text('Hapus')),
                //   ],
                // ),
              ],
            ),

/*            Text(
              "Id Lokasi : ${widget.data.idLokasi}",
              style: const TextStyle(fontSize: 16),
            ),
*/

            // Text(
            //   "Nama : ${widget.data.nama}",
            //   style: const TextStyle(fontSize: 16),
            // ),
            // Text(
            //   "Foto1 : ${widget.data.foto1}",
            //   style: const TextStyle(fontSize: 16),
            // ),
            // Text(
            //   "Foto2 : ${widget.data.foto2}",
            //   style: const TextStyle(fontSize: 16),
            // ),
            const SizedBox(height: 9),
            Text(
              "${widget.data.deskripsi}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 9),

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

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  ImageSlider({required this.imageUrls});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200, // Sesuaikan dengan tinggi yang Anda inginkan
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: 9),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.imageUrls.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
