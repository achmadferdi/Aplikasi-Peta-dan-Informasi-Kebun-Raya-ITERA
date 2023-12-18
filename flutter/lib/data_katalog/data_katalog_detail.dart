import 'package:flutter/material.dart';
import 'package:ridikc_crud/config/color.dart';
import 'package:ridikc_crud/config/config_global.dart';
import 'package:ridikc_crud/data_katalog/data/data_katalog_apidata.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DataKatalogDetail extends StatefulWidget {
  static const routeName = "data_katalog/detail";

  const DataKatalogDetail({super.key});

  @override
  State<DataKatalogDetail> createState() => _DataKatalogDetailState();
}

class _DataKatalogDetailState extends State<DataKatalogDetail> {
  bool showHarga = false;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as DataKatalogApiData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(bottom: showHarga ? 115 : 75),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
/*                 Image.network(
                  "${ConfigGlobal.baseUrl}/admin/upload/${data.gambar}",
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/image-not-available.jpg",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.namaPelatihan ?? "-",
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 9),
                            // if (data.fasilitator != null)
                            //   FasilitatorWidget(data: data.fasilitator!),
                            Row(
                              children: [
                                const Icon(Icons.timer),
                                const SizedBox(width: 6),
                                Text(
                                  data.tanggalMulai == null
                                      ? "-"
                                      : ConfigGlobal.formatTanggal(
                                          data.tanggalMulai!),
                                )
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.people),
                                const SizedBox(width: 6),
                                Text(
                                  data.kuota == null
                                      ? "-"
                                      : " Kuota ${data.kuota!} peserta",
                                )
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.book_rounded),
                                const SizedBox(width: 6),
                                Text(
                                  data.sisa == null
                                      ? "-"
                                      : " Sisa ${data.sisa!} Kuota lagi",
                                )
                              ],
                            ),
                            const SizedBox(height: 6),
                            // if (data.lokasi != null)
                            //   LokasiWidget(
                            //       data: data.lokasi!, provinsi: data.provinsi),
                            // if (data.metodePelatihan != null)
                            //   MetodePelatihanWidget(
                            //       data: data.metodePelatihan!),
                            const SizedBox(height: 6),
                            VisibilityDetector(
                              key: Key("harga"),
                              onVisibilityChanged: (VisibilityInfo info) {
                                var visiblePercentage =
                                    info.visibleFraction * 100;
                                if (visiblePercentage == 0.0) {
                                  setState(() {
                                    showHarga = true;
                                  });
                                } else {
                                  setState(() {
                                    showHarga = false;
                                  });
                                }
                              },
                              child: Text(
                                ConfigGlobal.formatRupiah(data.harga),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_rounded)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Hanya tersedia ${data.sisa} kursi lagi, daftar sekarang!",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 3,
                  color: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: const Text(
                            "Informasi Pelatihan ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      if (data.lokasi?.lokasi != null)
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Lokasi : ${data.lokasi?.lokasi}",
                          ),
                        ),
                      if (data.provinsi?.provinsi != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Provinsi : ${data.provinsi?.provinsi}",
                            )),
                      if (data.tanggalMulai != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Tanggal mulai : ${ConfigGlobal.formatTanggal(data.tanggalMulai!)}",
                            )),
                      if (data.tanggalSelesai != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Tanggal selesai : ${ConfigGlobal.formatTanggal(data.tanggalSelesai!)}",
                            )),
                      if (data.tahun != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Tahun : ${data.tahun!}",
                            )),
                      if (data.jenisDiklat?.jenisDiklat != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Jenis diklat : ${data.jenisDiklat?.jenisDiklat}",
                            )),
                      if (data.jenisPelatihan?.jenisPelatihan != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Jenis pelatihan : ${data.jenisPelatihan?.jenisPelatihan}",
                            )),
                      if (data.komoditas?.komoditas != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Komoditas : ${data.komoditas?.komoditas}",
                            )),
                      if (data.perkebunan?.perkebunan != null)
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Perkebunan : ${data.perkebunan?.perkebunan}",
                            )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Program atau topik ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${data.programAtauTopik}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Persayaratan",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${data.persyaratan}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Target peserta ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${data.targetPeserta}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Kriteria peserta ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${data.kriteriaPeserta}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Spesifikasi diklat ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${data.spesifikasiDiklat}")
                    ],
                  ),
                ), */
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: 30,
        //   left: 9,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     backgroundColor: Style.buttonBackgroundColor,
        //     child: const Icon(Icons.arrow_back, color: Colors.white),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: showHarga ? 1.0 : 0.0,
                duration: showHarga
                    ? const Duration(milliseconds: 300)
                    : const Duration(milliseconds: 50),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Row(
                    children: [
                      const Text(
                        "Biaya ",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ConfigGlobal.formatRupiah(data.harga),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      var url = Uri(
                        scheme: 'https',
                        host: 'wa.me',
                        path: '6285211656425',
                      );
                      if (!await launchUrl(url,
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          Image.asset("assets/wa.png", height: 30),
                          const Text(
                            "Chat Whatsapp",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //     DataPembayaranScreen.routeName,
                      //     arguments: data);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: Style.buttonBackgroundColor,
                      child: Row(
                        children: [
                          Image.asset("assets/bayar_sekarang.png", height: 30),
                          const Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}

/* class FasilitatorWidget extends StatelessWidget {
  final DataFasilitatorApiData data;

  const FasilitatorWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.account_circle),
            const SizedBox(width: 6),
            Text(data.nama ?? ""),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

class LokasiWidget extends StatelessWidget {
  final DataLokasiApiData data;
  final DataProvinsiApiData? provinsi;

  const LokasiWidget({
    Key? key,
    required this.data,
    this.provinsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.home_filled),
            const SizedBox(width: 3),
            Text(data.lokasi ?? ""),
            if (provinsi?.provinsi != null) Text(", ${provinsi!.provinsi}"),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

class MetodePelatihanWidget extends StatelessWidget {
  final DataMetodePelatihanApiData data;

  const MetodePelatihanWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.lightGreen,
          ),
          child: Text(
            data.metodePelatihan ?? "-",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
} */
