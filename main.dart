import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const HuzurVaktiApp());
}

class HuzurVaktiApp extends StatelessWidget {
  const HuzurVaktiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Huzur Vakti',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Sakin Gece Mavisi
        primaryColor: const Color(0xFF1E293B),
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _seciliSayfa = 0;

  final List<Widget> _sayfalar = [
    const VakitlerSayfasi(),
    const DualarSayfasi(),
    const AyarlarSayfasi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _sayfalar[_seciliSayfa],
            ),
            // Kullanıcıyı hiç boğmayan, sadece alt kısımda duran ince şerit reklam alanı
            Container(
              height: 45,
              width: double.infinity,
              color: Colors.black38,
              alignment: Alignment.center,
              child: const Text(
                "[ Destek Alanı / İnce Banner Reklam ]",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seciliSayfa,
        onTap: (index) {
          setState(() {
            _seciliSayfa = index;
          });
        },
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            label: 'Vakitler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Dualar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. VAKITLER EKRANI
// ==========================================
class VakitlerSayfasi extends StatelessWidget {
  const VakitlerSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> vakitler = [
      {"isim": "İmsak", "saat": "04:08"},
      {"isim": "Güneş", "saat": "05:40"},
      {"isim": "Öğle", "saat": "13:02"},
      {"isim": "İkindi", "saat": "16:45"},
      {"isim": "Akşam", "saat": "19:25"},
      {"isim": "Yatsı", "saat": "20:55"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("📍 Ankara", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("Hicri 27 Muharrem", style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          // Kalan Süre Sayacı Kutusu
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.tealAccent.withOpacity(0.3)),
            ),
            child: Column(
              children: const [
                Text("AKŞAM'A KALAN", style: TextStyle(color: Colors.tealAccent, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("01 : 42 : 10", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Günün Vakitleri", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: vakitler.length,
              itemBuilder: (context, index) {
                bool aktifVakit = vakitler[index]["isim"] == "İkindi";
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: aktifVakit ? Colors.teal.withOpacity(0.2) : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(10),
                    border: aktifVakit ? Border.all(color: Colors.tealAccent) : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(vakitler[index]["isim"]!, style: TextStyle(fontSize: 16, fontWeight: aktifVakit ? FontWeight.bold : FontWeight.normal, color: Colors.white)),
                      Text(vakitler[index]["saat"]!, style: TextStyle(fontSize: 16, fontWeight: aktifVakit ? FontWeight.bold : FontWeight.normal, color: Colors.white)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. DUALAR EKRANI VE İÇERİK ARŞİVİ
// ==========================================
class DualarSayfasi extends StatelessWidget {
  const DualarSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dualarListesi = [
      {"baslik": "Nazar ve Korunma Duası", "aciklama": "Eûzü bi-kelimâtillâhi't-tâmmati min külli şeytanin ve hâmmetin..."},
      {"baslik": "Sıkıntı ve Ferahlık Duası", "aciklama": "Lâ ilâhe illallâhül'azîmülhalîm..."},
      {"baslik": "Ayetel Kürzi", "aciklama": "Allâhü lâ ilâhe illâ hüvel hayyül kayyûm..."},
      {"baslik": "Esmaü'l-Hüsna (Özet)", "aciklama": "Allah'ın en güzel isimleri ve anlamları..."},
      {"baslik": "Rabbena Atina", "aciklama": "Rabbenâ âtinâ fid-dünyâ haseneten ve fil-âhirati haseneten..."},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Dualar ve Zikirler", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: dualarListesi.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(dualarListesi[index]["baslik"]!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    subtitle: Text(dualarListesi[index]["aciklama"]!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.tealAccent),
                    onTap: () {
                      // Detay sayfasına geçiş simülasyonu
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. AYARLAR VE DESTEK EKRANI
// ==========================================
class AyarlarSayfasi extends StatelessWidget {
  const AyarlarSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ayarlar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 20),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.notifications_active_rounded, color: Colors.tealAccent),
            title: const Text("Vakit Bildirimleri", style: TextStyle(color: Colors.white)),
            trailing: Switch(value: true, activeColor: Colors.tealAccent, onChanged: (val) {}),
          ),
          const Divider(color: Colors.white12),
          const SizedBox(height: 10),
          // Kullanıcıyı hiç sıkmayan, gönüllü destek / reklam kaldırma alanı
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Row(
              children: const [
                Icon(Icons.coffee_rounded, color: Colors.amber, size: 28),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Reklamları Kaldır & Destek Ol", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber, fontSize: 15)),
                      SizedBox(height: 4),
                      Text("Tek seferlik cüzi katkıyla alt şeridi tamamen kapat.", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.info_outline_rounded, color: Colors.grey),
            title: Text("Uygulama Hakkında & Gizlilik", style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
