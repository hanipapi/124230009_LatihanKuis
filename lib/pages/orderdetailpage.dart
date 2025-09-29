import 'package:flutter/material.dart';
import 'package:latihanquiz/models/modeldata.dart';

class OrderDetailPage extends StatefulWidget {
  final MenuItem menuItem;

  const OrderDetailPage({super.key, required this.menuItem});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  int quantity = 1;
  int total = 0;
  final TextEditingController _controller = TextEditingController(text: "1");

  int get price => widget.menuItem.price; // price dari model sudah int

  @override
  void initState() {
    super.initState();
    total = price * quantity;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateTotal() {
    final input = int.tryParse(_controller.text) ?? 1;
    setState(() {
      quantity = input < 1 ? 1 : input; // minimal 1
      total = price * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.menuItem.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.menuItem.imageAsset,
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
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: updateTotal,
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
                        "Berhasil pesan ${widget.menuItem.name} x$quantity (Total: Rp $total)",
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
