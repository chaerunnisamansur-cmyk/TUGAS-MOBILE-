void main() {
  Map<String, Map<String, dynamic>> mahasiswa = {
    'Budi Santoso': {
      'nilai': [85, 90, 79, 92, 88],
      'absensi': 2
    },
    'Siti Rahayu': {
      'nilai': [55, 60, 58, 52, 45],
      'absensi': 5
    },
  };

  print('=== LAPORAN NILAI MAHASISWA ===\n');

  double totalRataRata = 0;
  double nilaiTertinggi = 0;
  double nilaiTerendah = 100;

  mahasiswa.forEach((nama, data) {
    List<int> nilai = data['nilai'];
    int absensi = data['absensi'];

    double rataRata = hitungRataRata(nilai);
    String grade = tentukanGrade(rataRata);
    bool lulus = cekKelulusan(rataRata, absensi);

    totalRataRata += rataRata;

    if (rataRata > nilaiTertinggi) {
      nilaiTertinggi = rataRata;
    }

    if (rataRata < nilaiTerendah) {
      nilaiTerendah = rataRata;
    }

    print('Nama       : $nama');
    print('Nilai      : $nilai');
    print('Rata-rata  : ${rataRata.toStringAsFixed(1)}');
    print('Grade      : $grade');
    print('Status     : ${lulus ? "LULUS" : "TIDAK LULUS"}');
    print('');
  });

  double rataRataKelas = totalRataRata / mahasiswa.length;

  print('=== STATISTIK KELAS ===');
  print('Nilai Tertinggi : ${nilaiTertinggi.toStringAsFixed(1)}');
  print('Nilai Terendah  : ${nilaiTerendah.toStringAsFixed(1)}');
  print('Rata-rata Kelas : ${rataRataKelas.toStringAsFixed(1)}');
}

double hitungRataRata(List<int> nilai) {
  int total = 0;

  for (int n in nilai) {
    total += n;
  }

  return total / nilai.length;
}

String tentukanGrade(double rataRata) {
  if (rataRata >= 85) {
    return 'A';
  } else if (rataRata >= 70) {
    return 'B';
  } else if (rataRata >= 60) {
    return 'C';
  } else if (rataRata >= 50) {
    return 'D';
  } else {
    return 'E';
  }
}

bool cekKelulusan(double rataRata, int absensi) {
  return rataRata >= 60 && absensi < 3;
}