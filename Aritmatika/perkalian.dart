import 'dart:io';

void main() {
  print("=== PROGRAM PERKALIAN ===");

  stdout.write("Masukkan angka pertama: ");
  int angka1 = int.parse(stdin.readLineSync()!);

  stdout.write("Masukkan angka kedua: ");
  int angka2 = int.parse(stdin.readLineSync()!);

  int hasil = angka1 * angka2;

  print("Hasil perkalian: $angka1 × $angka2 = $hasil");
}