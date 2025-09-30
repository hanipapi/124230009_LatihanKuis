import 'package:flutter/material.dart';
import 'pages/homepage.dart';

// Halaman Login
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ✅ Variabel untuk menampung input username & password
  String username = "";
  String password = "";

  // ✅ Status login sukses/gagal → dipakai untuk ubah warna tombol
  bool isLoginSukses = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("LOGIN PAGE"), // ✅ Judul AppBar
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            _usernameField(), // ✅ Input username
            _passwordField(), // ✅ Input password
            _loginButton(context), // ✅ Tombol login
          ],
        ),
      ),
    );
  }

  // ✅ Widget untuk input username
  Widget _usernameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextFormField(
        enabled: true,
        onChanged: (value) {
          username = value; // ✅ Simpan username ke variabel
        },
        decoration: const InputDecoration(
          hintText: 'Username',
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)), // ✅ Rounded border
          ),
        ),
      ),
    );
  }

  // ✅ Widget untuk input password
  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        onChanged: (value) {
          password = value; // ✅ Simpan password ke variabel
        },
        obscureText: true, // ✅ Sembunyikan teks password
        decoration: const InputDecoration(
          hintText: 'Password',
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color.fromARGB(255, 43, 255, 142)),
          ),
        ),
      ),
    );
  }

  // ✅ Widget tombol login
  Widget _loginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width, // ✅ Lebar tombol = full screen
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 255, 255, 255), // ✅ Warna teks putih
          backgroundColor: (isLoginSukses)
              ? const Color.fromARGB(255, 0, 198, 72) // ✅ Hijau kalau sukses
              : Colors.red, // ✅ Merah kalau gagal
        ),
        onPressed: () {
          String text = "";

          // ✅ Cek username & password
          if (username == "fulan" && password == "fulan") {
            setState(() {
              text = "Login Berhasil"; // ✅ Pesan sukses
              isLoginSukses = true;
            });

            // ✅ Jika berhasil, pindah ke Homepage + bawa username
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Homepage(username: username);
                },
              ),
            );
          } else {
            setState(() {
              text = "Login Gagal"; // ✅ Pesan gagal
              isLoginSukses = false;
            });
          }

          // ✅ Tampilkan SnackBar untuk feedback login
          SnackBar snackBar = SnackBar(content: Text(text));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Login'), // ✅ Label tombol
      ),
    );
  }
}
