import 'package:flutter/material.dart';
import 'panen.dart';

class PanenCard extends StatelessWidget {
  final Panen panen;
  final VoidCallback onTap;

  const PanenCard({
    super.key,
    required this.panen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool perlu = panen.perluDitinjau();
    bool stokSedikit = panen.stokSedikit();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: perlu
              ? Colors.orange.shade200
              : stokSedikit
                  ? Colors.red.shade200
                  : Colors.green.shade200,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 70,
                      height: 70,
                      color: Colors.green.shade50,
                      child: Image.asset(
                        panen.gambar,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 35,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          panen.komoditas,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                panen.petak,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    panen.tanggal,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.scale, size: 18, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Berat Panen'),
                    ],
                  ),
                  Text(
                    '${panen.beratKg} kg',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 18,
                        color: Colors.green,
                      ),
                      SizedBox(width: 8),
                      Text('Harga / kg'),
                    ],
                  ),
                  Text(
                    rupiah(panen.hargaPerKg),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.calculate_outlined,
                        size: 18,
                        color: Colors.green,
                      ),
                      SizedBox(width: 8),
                      Text('Nilai Panen'),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      rupiah(panen.hitungNilai()),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 18,
                        color: stokSedikit ? Colors.red : Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const Text('Stok'),
                    ],
                  ),
                  Text(
                    '${panen.stokKg} kg',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: stokSedikit ? Colors.red : Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.local_offer_outlined,
                        size: 18,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 8),
                      Text('Diskon'),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      '-${panen.diskonPersen}% -${rupiah(panen.hitungDiskon())}',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: perlu
                      ? Colors.orange.shade50
                      : stokSedikit
                          ? Colors.red.shade50
                          : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: perlu
                        ? Colors.orange.shade200
                        : stokSedikit
                            ? Colors.red.shade200
                            : Colors.green.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      perlu
                          ? Icons.warning_amber
                          : stokSedikit
                              ? Icons.warning
                              : Icons.check_circle,
                      size: 18,
                      color: perlu
                          ? Colors.orange
                          : stokSedikit
                              ? Colors.red
                              : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        perlu
                            ? 'Perlu ditinjau'
                            : stokSedikit
                                ? 'Limit stok'
                                : 'Kualitas baik',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: perlu
                              ? Colors.orange.shade800
                              : stokSedikit
                                  ? Colors.red.shade800
                                  : Colors.green.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'Klik kartu untuk melihat rincian',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}