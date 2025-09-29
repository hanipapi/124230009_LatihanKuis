import 'package:flutter/material.dart';
import 'package:latihanquiz_009/models/modeldata.dart';

class OrderDetailPage extends StatefulWidget {
  final MenuItem menuItem; // ✅ pakai MenuItem, bukan Map

  const OrderDetailPage({super.key, required this.menuItem});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  int quantity = 1;
  int get price {
    final raw = widget.menuItem.price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(raw) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final total = price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuItem.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.menuItem.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.menuItem.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Harga: Rp ${price.toString()}",
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Jumlah:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    if (quantity > 1) setState(() => quantity--);
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                ),
                Text("$quantity", style: const TextStyle(fontSize: 20)),
                IconButton(
                  onPressed: () {
                    setState(() => quantity++);
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Total: Rp $total",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Berhasil pesan ${widget.menuItem.name} x$quantity (Total: Rp $total)"),
                    ),
                  );
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
            )
          ],
        ),
      ),
    );
  }
}
