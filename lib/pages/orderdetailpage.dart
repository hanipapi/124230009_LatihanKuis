import 'package:flutter/material.dart';
import 'package:latihanquiz/models/modeldata.dart';

// Halaman detail pesanan
class OrderDetailPage extends StatefulWidget {
  final MenuItem menuItem; // ✅ Data menu yang dipilih user dikirim dari halaman sebelumnya

  const OrderDetailPage({super.key, required this.menuItem});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  int quantity = 1; // ✅ Jumlah item default = 1
  int total = 0; // ✅ Total harga, dihitung dari harga * jumlah
  final TextEditingController _controller = TextEditingController(text: "1"); 
  // ✅ Controller untuk input jumlah item (biar bisa diubah user manual lewat TextField)

  int get price => widget.menuItem.price; 
  // ✅ Getter untuk ambil harga dari model MenuItem

  @override
  void initState() {
    super.initState();
    total = price * quantity; // ✅ Saat halaman dibuka, total langsung dihitung
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ Pastikan controller dibersihkan dari memori
    super.dispose();
  }

  void updateTotal() {
    final input = int.tryParse(_controller.text) ?? 1; 
    // ✅ Ambil angka dari TextField, kalau kosong/invalid default = 1
    setState(() {
      quantity = input < 1 ? 1 : input; // ✅ Minimal pembelian 1
      total = price * quantity; // ✅ Hitung ulang total
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.menuItem.name)), // ✅ Judul appbar pakai nama menu
      body: Padding(
        padding: const EdgeInsets.all(16.0), // ✅ Padding biar konten gak mepet
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Tampilan gambar menu
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // ✅ Bikin gambar rounded
                child: Image.asset(
                  widget.menuItem.imageAsset, // ✅ Ambil gambar dari model
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Nama menu
            Text(
              widget.menuItem.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // ✅ Harga satuan
            Text(
              "Harga: Rp $price",
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // ✅ Input jumlah + tombol Update
            Row(
              children: [
                const Text(
                  "Jumlah:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _controller, // ✅ Hubungkan ke TextEditingController
                    keyboardType: TextInputType.number, // ✅ Hanya angka
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // ✅ Tombol untuk update jumlah
                ElevatedButton(
                  onPressed: updateTotal, // ✅ Jalankan fungsi update total
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  child: const Text("Update"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ✅ Menampilkan total harga
            Text(
              "Total: Rp $total",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const Spacer(), // ✅ Dorong tombol ke bawah layar

            // ✅ Tombol Pesan Sekarang
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ✅ Tampilkan pesan sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Berhasil pesan ${widget.menuItem.name} x$quantity (Total: Rp $total)",
                      ),
                    ),
                  );

                  // ✅ Kembali ke halaman sebelumnya (HomePage)
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Pesan Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
