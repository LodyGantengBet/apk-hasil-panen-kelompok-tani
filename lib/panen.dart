class Panen {
  String komoditas;
  String petak;
  String tanggal;
  int beratKg;
  int hargaPerKg;
  String gambar;
  int stokKg;
  int diskonPersen;

  Panen({
    required this.komoditas,
    required this.petak,
    required this.tanggal,
    required this.beratKg,
    required this.hargaPerKg,
    required this.gambar,
    required this.stokKg,
    required this.diskonPersen,
  });

  int hitungNilai() {
    return beratKg * hargaPerKg;
  }

  int hitungDiskon() {
    return hitungNilai() * diskonPersen ~/ 100;
  }

  int hitungNilaiAkhir() {
    return hitungNilai() - hitungDiskon();
  }

  bool perluDitinjau() {
    return beratKg < 100;
  }

  bool stokSedikit() {
    return stokKg < 50;
  }
}

List<Panen> dataPanen = [
  Panen(
    komoditas: 'Padi',
    petak: 'Blok B1',
    tanggal: '03 Sep 2026',
    beratKg: 320,
    hargaPerKg: 6800,
    gambar: 'assets/images/padi.png',
    stokKg: 210,
    diskonPersen: 5,
  ),
  Panen(
    komoditas: 'Kedelai',
    petak: 'Blok C2',
    tanggal: '04 Sep 2026',
    beratKg: 85,
    hargaPerKg: 9200,
    gambar: 'assets/images/kedelai.png',
    stokKg: 30,
    diskonPersen: 10,
  ),
  Panen(
    komoditas: 'Cabai',
    petak: 'Blok A4',
    tanggal: '05 Sep 2026',
    beratKg: 65,
    hargaPerKg: 28000,
    gambar: 'assets/images/cabai.png',
    stokKg: 18,
    diskonPersen: 15,
  ),
  Panen(
    komoditas: 'Bawang Merah',
    petak: 'Blok D1',
    tanggal: '06 Sep 2026',
    beratKg: 145,
    hargaPerKg: 31000,
    gambar: 'assets/images/bawang_merah.jpg',
    stokKg: 75,
    diskonPersen: 5,
  ),
  Panen(
    komoditas: 'Kacang Tanah',
    petak: 'Blok B3',
    tanggal: '07 Sep 2026',
    beratKg: 110,
    hargaPerKg: 12500,
    gambar: 'assets/images/kacang_tanah.jpg',
    stokKg: 45,
    diskonPersen: 5,
  ),
  Panen(
    komoditas: 'Jagung Super Unggul Hasil Panen Terbaik Kelompok Tani',
    petak: 'Blok C4',
    tanggal: '08 Sep 2026',
    beratKg: 275,
    hargaPerKg: 5700,
    gambar: 'assets/images/jagung_manis.png',
    stokKg: 120,
    diskonPersen: 10,
  ),
  Panen(
    komoditas: 'Tomat',
    petak: 'Blok A2',
    tanggal: '09 Sep 2026',
    beratKg: 72,
    hargaPerKg: 11500,
    gambar: 'assets/images/tomat.png',
    stokKg: 25,
    diskonPersen: 10,
  ),
  Panen(
    komoditas: 'Mentimun',
    petak: 'Blok D3',
    tanggal: '10 Sep 2026',
    beratKg: 190,
    hargaPerKg: 7500,
    gambar: 'assets/images/mentimun.png',
    stokKg: 60,
    diskonPersen: 5,
  ),
];

String rupiah(int angka) {
  String hasil = angka.toString();
  String baru = '';
  int hitung = 0;

  for (int i = hasil.length - 1; i >= 0; i--) {
    baru = hasil[i] + baru;
    hitung++;

    if (hitung == 3 && i != 0) {
      baru = '.$baru';
      hitung = 0;
    }
  }

  return 'Rp $baru';
}