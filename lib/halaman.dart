import 'package:flutter/material.dart';
import 'panen.dart';
import 'panen_card.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Panen> get hasilPencarian {
    String kata = controller.text.toLowerCase();

    if (kata.isEmpty) {
      return dataPanen;
    }

    List<Panen> hasil = [];

    for (Panen panen in dataPanen) {
      bool cocokKomoditas =
          panen.komoditas.toLowerCase().contains(kata);
      bool cocokPetak = panen.petak.toLowerCase().contains(kata);

      if (cocokKomoditas || cocokPetak) {
        hasil.add(panen);
      }
    }

    return hasil;
  }

  int hitungTotal() {
    int total = 0;

    for (Panen panen in hasilPencarian) {
      total = total + panen.hitungNilai();
    }

    return total;
  }

  int jumlahKolom(double lebar) {
    if (lebar < 600) {
      return 1;
    } else if (lebar < 900) {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KOPDES',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.agriculture),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Tentang KOPDES'),
                    content: const Text(
                      'KOPDES adalah aplikasi pencatatan '
                      'hasil panen kelompok tani.\n\n'
                      'Aplikasi digunakan untuk mencatat '
                      'komoditas, petak, tanggal, berat, '
                      'dan harga hasil panen.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Tutup'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, ukuran) {
          bool mobile = ukuran.maxWidth < 600;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(mobile ? 12 : 16),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari komoditas atau petak...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mobile ? 12 : 16,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(mobile ? 16 : 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.green.shade200,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Nilai Hasil Panen',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        rupiah(hitungTotal()),
                        style: TextStyle(
                          fontSize: mobile ? 22 : 26,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1B5E20),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${hasilPencarian.length} data ditampilkan',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: hasilPencarian.isEmpty
                    ? const Center(
                        child: Text(
                          'Data panen tidak ditemukan',
                        ),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.all(
                          mobile ? 12 : 16,
                        ),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              jumlahKolom(ukuran.maxWidth),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 390,
                        ),
                        itemCount: hasilPencarian.length,
                        itemBuilder: (context, index) {
                          Panen panen = hasilPencarian[index];

                          return PanenCard(
                            panen: panen,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HalamanRincian(
                                      panen: panen,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HalamanRincian extends StatelessWidget {
  final Panen panen;

  const HalamanRincian({
    super.key,
    required this.panen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Panen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: Image.asset(
                      panen.gambar,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    panen.komoditas,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    barisData('Komoditas', panen.komoditas),
                    const Divider(),
                    barisData('Petak', panen.petak),
                    const Divider(),
                    barisData('Tanggal', panen.tanggal),
                    const Divider(),
                    barisData(
                      'Berat Panen',
                      '${panen.beratKg} kg',
                    ),
                    const Divider(),
                    barisData(
                      'Harga / kg',
                      rupiah(panen.hargaPerKg),
                    ),
                    const Divider(),
                    barisData(
                      'Nilai Panen',
                      rupiah(panen.hitungNilai()),
                    ),
                    const Divider(),
                    barisData(
                      'Stok',
                      '${panen.stokKg} kg',
                    ),
                    const Divider(),
                    barisData(
                      'Diskon',
                      '${panen.diskonPersen}%',
                    ),
                    const Divider(),
                    barisData(
                      'Potongan',
                      rupiah(panen.hitungDiskon()),
                    ),
                    const Divider(),
                    barisData(
                      'Nilai Akhir',
                      rupiah(panen.hitungNilaiAkhir()),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: PenyesuaiBerat(
                  beratAwal: panen.beratKg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget barisData(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            judul,
            style: const TextStyle(color: Colors.grey),
          ),
          Flexible(
            child: Text(
              isi,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PenyesuaiBerat extends StatefulWidget {
  final int beratAwal;

  const PenyesuaiBerat({
    super.key,
    required this.beratAwal,
  });

  @override
  State<PenyesuaiBerat> createState() => _PenyesuaiBeratState();
}

class _PenyesuaiBeratState extends State<PenyesuaiBerat> {
  late int berat;

  @override
  void initState() {
    super.initState();
    berat = widget.beratAwal;
  }

  void kurangiBerat() {
    setState(() {
      if (berat >= 5) {
        berat = berat - 5;
      }
    });
  }

  void tambahBerat() {
    setState(() {
      berat = berat + 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Penyesuai Berat',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: kurangiBerat,
              child: const Text(
                '-',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(width: 25),
            Text(
              '$berat kg',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 25),
            ElevatedButton(
              onPressed: tambahBerat,
              child: const Text(
                '+',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Tekan + atau - untuk mengubah berat 5 kg',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}