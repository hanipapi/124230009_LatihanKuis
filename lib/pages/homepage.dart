import 'package:flutter/material.dart';
import 'package:latihanquiz/data/menulist.dart'; // Import data list menu (dummy menu)
import 'package:latihanquiz/models/modeldata.dart'; // Import model MenuItem
import 'orderdetailpage.dart'; // Import halaman detail order
import 'package:latihanquiz/login_page.dart'; // Import halaman login (untuk logout)

class Homepage extends StatelessWidget {
  final String username; // Menyimpan username yang dikirim dari login

  const Homepage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Struktur utama halaman
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true, // Supaya judul AppBar ditengah
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Teks sapaan username
            Text(
              "Halo @$username",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            // Teks tambahan di bawah sapaan
            const Text(
              "Hari ini mau makan apa?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          // Tombol logout di kanan atas
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              // Aksi logout -> kembali ke login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ],
      ),

      // Isi halaman
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner image di atas menu
            Image.network(
              "https://images.unsplash.com/photo-1600891964599-f61ba0e24092",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 12),

            // Judul "Daftar Menu"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Daftar Menu:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            // Grid menu makanan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Scroll ikut SingleChildScrollView
                shrinkWrap: true, // Biar grid menyesuaikan ukuran
                itemCount: menuList.length, // Jumlah item menu
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom (2 menu per baris)
                  mainAxisSpacing: 12, // Jarak antar baris
                  crossAxisSpacing: 12, // Jarak antar kolom
                  childAspectRatio: 0.75, // Rasio ukuran card
                ),
                itemBuilder: (context, index) {
                  final MenuItem item = menuList[index]; // Ambil data menu
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3, // Efek bayangan card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Bagian gambar menu
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.asset(
                              item.imageAsset, // Gambar dari assets
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.fastfood, size: 50),
                            ),
                          ),
                        ),

                        // Bagian teks nama, harga, dan tombol pesan
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nama menu
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Harga menu
                              Text(
                                "Rp ${item.price}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Tombol pesan
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Pindah ke halaman detail pesanan
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            OrderDetailPage(menuItem: item),
                                      ),
                                    );
                                  },
                                  child: const Text("Pesan"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
