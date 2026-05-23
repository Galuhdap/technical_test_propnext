int parseSalary(String? value) {
  if (value == null || value.isEmpty) return 0;

  // Hilangkan karakter non-angka dan huruf
  String cleaned = value.replaceAll(RegExp(r'[^0-9a-zA-Z]'), '').toLowerCase();

  if (cleaned.contains('jt')) {
    // ambil angka sebelum "jt"
    final number = int.tryParse(cleaned.replaceAll('rp', '').replaceAll('jt', '')) ?? 0;
    return number * 1000000; // ubah ke juta
  }

  return int.tryParse(cleaned) ?? 0;
}
