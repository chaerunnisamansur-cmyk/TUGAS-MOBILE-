import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// FUNGSI KATEGORI RATING
// =====================================================

String kategoriRating(double rating) {
  if (rating >= 4.5) {
    return 'Sangat Baik';
  } else if (rating >= 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}

// =====================================================
// DATA BUKU
// =====================================================

final List<Map<String, dynamic>> daftarBuku = [
  {
    'judul': 'Laskar Pelangi',
    'pengarang': 'Andrea Hirata',
    'tahunTerbit': 2005,
    'rating': 4.8,
    'tersedia': true,
    'genre': 'Novel',
  },
  {
    'judul': 'Bumi Manusia',
    'pengarang': 'Pramoedya Ananta Toer',
    'tahunTerbit': 1980,
    'rating': 4.7,
    'tersedia': false,
    'genre': 'Sejarah',
  },
  {
    'judul': 'Negeri 5 Menara',
    'pengarang': 'Ahmad Fuadi',
    'tahunTerbit': 2009,
    'rating': 4.5,
    'tersedia': true,
    'genre': 'Novel',
  },
  {
    'judul': 'Filosofi Teras',
    'pengarang': 'Henry Manampiring',
    'tahunTerbit': 2018,
    'rating': 4.3,
    'tersedia': true,
    'genre': 'Pengembangan Diri',
  },
  {
    'judul': 'Atomic Habits',
    'pengarang': 'James Clear',
    'tahunTerbit': 2018,
    'rating': 4.6,
    'tersedia': false,
    'genre': 'Pengembangan Diri',
  },
  {
    'judul': 'Harry Potter',
    'pengarang': 'J.K. Rowling',
    'tahunTerbit': 1997,
    'rating': 4.9,
    'tersedia': true,
    'genre': 'Fantasi',
  },
];

// =====================================================
// MY APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Buku Perpustakaan Mini',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const KatalogPage(),
    );
  }
}

// =====================================================
// HALAMAN KATALOG
// =====================================================

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  String kataPencarian = '';

  @override
  Widget build(BuildContext context) {
    // =================================================
    // SET UNTUK MENYIMPAN GENRE UNIK
    // =================================================

    Set<String> genreUnik = daftarBuku
        .map((buku) => buku['genre'] as String)
        .toSet();

    // =================================================
    // FILTER MENGGUNAKAN .WHERE()
    // =================================================

    List<Map<String, dynamic>> bukuTersaring = daftarBuku.where((buku) {
      String judul = buku['judul'].toString().toLowerCase();

      return judul.contains(kataPencarian.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Buku Perpustakaan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // =================================================
      // BODY
      // =================================================

      body: Column(
        children: [
          // =================================================
          // TEXTFIELD PENCARIAN
          // =================================================

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari judul buku...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  kataPencarian = value;
                });
              },
            ),
          ),

          // =================================================
          // GENRE DALAM CHIP
          // =================================================

          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: genreUnik.map((genre) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    avatar: const Icon(
                      Icons.book,
                      size: 18,
                    ),
                    label: Text(genre),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),

          // =================================================
          // JUMLAH BUKU
          // =================================================

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menampilkan ${bukuTersaring.length} buku',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // =================================================
          // LISTVIEW BUILDER
          // =================================================

          Expanded(
            child: bukuTersaring.isEmpty
                ? const Center(
                    child: Text(
                      'Buku tidak ditemukan',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: bukuTersaring.length,
                    itemBuilder: (context, index) {
                      final buku = bukuTersaring[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              // =========================
                              // JUDUL
                              // =========================

                              Text(
                                buku['judul'] as String,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // =========================
                              // PENGARANG
                              // =========================

                              Text(
                                'Pengarang : ${buku['pengarang']}',
                              ),

                              Text(
                                'Tahun Terbit : ${buku['tahunTerbit']}',
                              ),

                              Text(
                                'Genre : ${buku['genre']}',
                              ),

                              const SizedBox(height: 4),

                              // =========================
                              // RATING
                              // =========================

                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${buku['rating']} '
                                    '(${kategoriRating(buku['rating'] as double)})',
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // =========================
                              // BADGE TERSEDIA / DIPINJAM
                              // =========================

                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: buku['tersedia'] as bool
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),
                                child: Text(
                                  buku['tersedia'] as bool
                                      ? 'Tersedia'
                                      : 'Dipinjam',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // =========================
                              // TOMBOL DETAIL
                              // =========================

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailBukuPage(
                                          judul:
                                              buku['judul'] as String,
                                          pengarang:
                                              buku['pengarang'] as String,
                                          tahunTerbit:
                                              buku['tahunTerbit'] as int,
                                          rating:
                                              buku['rating'] as double,
                                          tersedia:
                                              buku['tersedia'] as bool,
                                          genre:
                                              buku['genre'] as String,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                  ),
                                  label: const Text(
                                    'Lihat Detail',
                                  ),
                                ),
                              ),
                            ],
                          ),
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

// =====================================================
// HALAMAN DETAIL
// STATEFUL WIDGET
// =====================================================

class DetailBukuPage extends StatefulWidget {
  final String judul;
  final String pengarang;
  final int tahunTerbit;
  final double rating;
  final bool tersedia;
  final String genre;

  const DetailBukuPage({
    super.key,
    required this.judul,
    required this.pengarang,
    required this.tahunTerbit,
    required this.rating,
    required this.tersedia,
    required this.genre,
  });

  @override
  State<DetailBukuPage> createState() => _DetailBukuPageState();
}

class _DetailBukuPageState extends State<DetailBukuPage> {
  // Field String yang bisa bernilai null
  String? catatanPeminjam;

  @override
  Widget build(BuildContext context) {
    // Operator ?? memberikan nilai default
    String catatan =
        catatanPeminjam ?? 'Tidak ada catatan';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.menu_book,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              widget.judul,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Pengarang : ${widget.pengarang}',
              style: const TextStyle(fontSize: 16),
            ),

            Text(
              'Tahun Terbit : ${widget.tahunTerbit}',
              style: const TextStyle(fontSize: 16),
            ),

            Text(
              'Genre : ${widget.genre}',
              style: const TextStyle(fontSize: 16),
            ),

            Text(
              'Rating : ${widget.rating}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 15),

            // =================================================
            // STATUS BUKU
            // =================================================

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.tersedia
                    ? Colors.green
                    : Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.tersedia
                    ? 'BUKU TERSEDIA'
                    : 'BUKU SEDANG DIPINJAM',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // CATATAN PEMINJAM
            // =================================================

            const Text(
              'Catatan Peminjam:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              catatan,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // TOMBOL TAMBAH CATATAN
            // =================================================

            ElevatedButton(
              onPressed: () {
                setState(() {
                  catatanPeminjam =
                      'Buku sedang diproses untuk peminjaman.';
                });
              },
              child: const Text(
                'Tambah Catatan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}