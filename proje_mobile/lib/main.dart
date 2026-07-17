import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mekan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proje Mobil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MekanlarSayfasi(),
    );
  }
}

class MekanlarSayfasi extends StatefulWidget {
  const MekanlarSayfasi({super.key});

  @override
  State<MekanlarSayfasi> createState() => _MekanlarSayfasiState();
}

class _MekanlarSayfasiState extends State<MekanlarSayfasi> {
  List<Mekan> mekanlar = [];
  bool yukleniyor = true;

  final String apiUrl = 'http://localhost:5221/api/Mekanlar';

  @override
  void initState() {
    super.initState();
    mekanlariGetir();
  }

  Future<void> mekanlariGetir() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> veriler = json.decode(response.body);
        setState(() {
          mekanlar = veriler.map((data) => Mekan.fromJson(data)).toList();
          yukleniyor = false;
        });
      } else {
        setState(() {
          yukleniyor = false;
        });
      }
    } catch (e) {
      debugPrint('Hata oluştu: $e');
      setState(() {
        yukleniyor = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mekan Rehberi'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : mekanlar.isEmpty
          ? const Center(child: Text('Henüz eklenmiş mekan yok.'))
          : ListView.builder(
              itemCount: mekanlar.length,
              itemBuilder: (context, index) {
                final mekan = mekanlar[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text(
                        mekan.mekanID.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      mekan.mekanAdi,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(mekan.sehir),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '⭐ ${mekan.ziyaretciPuani}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
