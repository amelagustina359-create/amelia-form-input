// Pertemuan 5 - Form tambah data mahasiswa dengan validasi (Tugas 4)
// Pustaka yang dipakai hanya material.dart dan services.dart (sesuai batasan tugas).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// Warna tema yang dipakai di seluruh aplikasi.
const Color warnaUtama = Color(0xFF00796B);
const Color warnaGelap = Color(0xFF004D40);
const Color warnaTerang = Color(0xFF26A69A);
const Color warnaLatar = Color(0xFFF2F7F6);
const Color warnaGaris = Color(0xFFD5E6E3);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Akademik Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: warnaUtama),
        scaffoldBackgroundColor: warnaLatar,
      ),
      home: const DashboardPage(),
    );
  }
}

// Data contoh untuk daftar di Dashboard.
// Data dari form TIDAK dimasukkan ke daftar ini (itu materi Pertemuan 6).
const List<Map<String, String>> daftarMahasiswa = [
  {
    'nama': 'Rina Amelia',
    'nim': '2023001',
    'prodi': 'Sistem Informasi',
    'semester': '5',
    'email': 'rina@contoh.ac.id',
  },
  {
    'nama': 'Budi Santoso',
    'nim': '2023002',
    'prodi': 'Sistem Informasi',
    'semester': '5',
    'email': 'budi@contoh.ac.id',
  },
  {
    'nama': 'Siti Rahma',
    'nim': '2023003',
    'prodi': 'Sistem Informasi',
    'semester': '3',
    'email': 'siti@contoh.ac.id',
  },
];

// ---------------------------------------------------------------------------
// WIDGET PEMBANTU UNTUK TAMPILAN
// ---------------------------------------------------------------------------

// Kartu putih dengan sudut membulat, dipakai berulang di banyak halaman.
class KartuPutih extends StatelessWidget {
  const KartuPutih({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: warnaGaris),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child is ListTile
          ? Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAlias,
              child: child,
            )
          : child,
    );
  }
}

// Banner hijau bergradasi di bagian atas halaman.
class BannerGradasi extends StatelessWidget {
  const BannerGradasi({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [warnaGelap, warnaTerang],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33004D40),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

// Tampilan kolom isian yang seragam untuk keempat TextFormField.
InputDecoration dekorasi({
  required String label,
  required String hint,
  required IconData ikon,
}) {
  OutlineInputBorder garis(Color warna, double tebal) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: warna, width: tebal),
      );

  return InputDecoration(
    labelText: label,
    hintText: hint,
    counterText: '',
    prefixIcon: Icon(ikon, color: warnaUtama),
    filled: true,
    fillColor: const Color(0xFFF7FBFA),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: garis(warnaGaris, 1),
    enabledBorder: garis(warnaGaris, 1),
    focusedBorder: garis(warnaUtama, 2),
    errorBorder: garis(Colors.red.shade400, 1.5),
    focusedErrorBorder: garis(Colors.red.shade600, 2),
  );
}

// ---------------------------------------------------------------------------
// HALAMAN 1: DASHBOARD
// Tombol "Tambah" (FloatingActionButton) membuka TambahMahasiswaPage.
// ---------------------------------------------------------------------------
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard Akademik',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: warnaLatar,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TambahMahasiswaPage()),
        ),
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Tambah'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          // Kartu sapaan berisi identitas singkat.
          BannerGradasi(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 34, color: warnaUtama),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selamat datang,',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        ProfilPage.profil['Nama']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${ProfilPage.profil['Program Studi']} · '
                        'Semester ${ProfilPage.profil['Semester']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Menu menuju halaman Profil.
          KartuPutih(
            padding: EdgeInsets.zero,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F2F1),
                child: Icon(Icons.badge, color: warnaUtama),
              ),
              title: const Text(
                'Profil Saya',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Identitas dan keahlian'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilPage()),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Daftar Mahasiswa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          for (final mhs in daftarMahasiswa)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: KartuPutih(
                padding: EdgeInsets.zero,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: warnaUtama,
                    foregroundColor: Colors.white,
                    child: Text(mhs['nama']![0]),
                  ),
                  title: Text(
                    mhs['nama']!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('NIM ${mhs['nim']}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMahasiswaPage(mahasiswa: mhs),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ATURAN VALIDASI (Tabel Rancangan)
// Aturan: kembalikan String = ada galat, kembalikan null = valid.
// ---------------------------------------------------------------------------

// Nama: wajib isi, minimal 3 huruf, TIDAK boleh berisi angka (aturan tambahan).
String? validasiNama(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'Nama wajib diisi';
  if (t.length < 3) return 'Nama minimal 3 huruf';
  if (!RegExp(r"^[A-Za-z .'-]+$").hasMatch(t)) {
    return 'Nama hanya boleh berisi huruf, tanpa angka (contoh: Rina Amelia)';
  }
  return null;
}

// NIM: wajib isi, hanya angka (RegExp), minimal 7 digit.
String? validasiNim(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'NIM wajib diisi';
  if (!RegExp(r'^[0-9]+$').hasMatch(t)) return 'NIM hanya boleh berisi angka';
  if (t.length < 7) return 'NIM minimal 7 digit';
  return null;
}

// Email: wajib isi, format email valid, dan berakhiran .ac.id (aturan tambahan).
// Kalau mau dilonggarkan, hapus blok "if (!t.toLowerCase().endsWith..." saja.
String? validasiEmail(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'Email wajib diisi';
  if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(t)) {
    return 'Format email tidak valid (contoh: nama@kampus.ac.id)';
  }
  if (!t.toLowerCase().endsWith('.ac.id')) {
    return 'Gunakan email kampus berakhiran .ac.id (contoh: nama@kampus.ac.id)';
  }
  return null;
}

// Semester: wajib isi, harus angka, rentang 1 sampai 14.
String? validasiSemester(String? val) {
  final t = val?.trim() ?? '';
  if (t.isEmpty) return 'Semester wajib diisi';
  final a = int.tryParse(t);
  if (a == null) return 'Semester harus berupa angka';
  if (a < 1 || a > 14) return 'Semester harus antara 1 dan 14';
  return null;
}

// ---------------------------------------------------------------------------
// HALAMAN 2: FORM TAMBAH MAHASISWA (StatefulWidget karena isinya berubah)
// ---------------------------------------------------------------------------
class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({super.key});

  @override
  State<TambahMahasiswaPage> createState() => _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState extends State<TambahMahasiswaPage> {
  // Kunci untuk memanggil validate() dan reset() pada Form.
  final _formKey = GlobalKey<FormState>();

  // Controller: membaca dan mengosongkan isi tiap kolom.
  final _namaC = TextEditingController();
  final _nimC = TextEditingController();
  final _emailC = TextEditingController();
  final _semC = TextEditingController();

  // FocusNode: supaya kursor bisa dikembalikan ke kolom Nama.
  final _namaF = FocusNode();

  // Awalnya validasi mati, supaya pesan merah tidak muncul sebelum mengisi.
  AutovalidateMode _mode = AutovalidateMode.disabled;

  // Hasil data valid, ditampilkan sebagai kotak Pratinjau.
  Map<String, String>? _hasil;

  // WAJIB: lepas semua controller dan focus node saat halaman ditutup.
  @override
  void dispose() {
    _namaC.dispose();
    _nimC.dispose();
    _emailC.dispose();
    _semC.dispose();
    _namaF.dispose();
    super.dispose();
  }

  void _simpan() {
    // Turunkan keyboard.
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      // Semua kolom benar: simpan ke state agar Pratinjau tampil.
      setState(() {
        _hasil = {
          'nama': _namaC.text.trim(),
          'nim': _nimC.text.trim(),
          'email': _emailC.text.trim(),
          'semester': _semC.text.trim(),
        };
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: warnaUtama,
          content: Text('Data ${_hasil!['nama']} valid.'),
        ),
      );
    } else {
      // Ada yang salah: mulai pantau ketikan agar pesan merah hilang otomatis
      // saat isian diperbaiki.
      setState(() => _mode = AutovalidateMode.onUserInteraction);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade700,
          content: const Text('Periksa kembali isian yang ditandai merah.'),
        ),
      );
    }
  }

  void _kosongkan() {
    _formKey.currentState!.reset();
    _namaC.clear();
    _nimC.clear();
    _emailC.clear();
    _semC.clear();
    setState(() {
      _hasil = null;
      _mode = AutovalidateMode.disabled;
    });
    // Kursor kembali ke kolom pertama (Nama).
    _namaF.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: warnaLatar,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner penjelasan singkat.
            const BannerGradasi(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_add, color: warnaUtama, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data Mahasiswa Baru',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Isi semua kolom dengan benar, lalu tekan Simpan.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Kartu berisi formulir.
            KartuPutih(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                autovalidateMode: _mode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. NAMA: kursor langsung aktif, huruf awal kapital.
                    TextFormField(
                      controller: _namaC,
                      focusNode: _namaF,
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: dekorasi(
                        label: 'Nama lengkap',
                        hint: 'mis. Rina Amelia',
                        ikon: Icons.person,
                      ),
                      validator: validasiNama,
                    ),
                    const SizedBox(height: 16),

                    // 2. NIM: keyboard angka, huruf diblokir (digitsOnly).
                    TextFormField(
                      controller: _nimC,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 12,
                      decoration: dekorasi(
                        label: 'NIM',
                        hint: 'hanya angka',
                        ikon: Icons.badge,
                      ),
                      validator: validasiNim,
                    ),
                    const SizedBox(height: 16),

                    // 3. EMAIL: keyboard dengan simbol @.
                    TextFormField(
                      controller: _emailC,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: dekorasi(
                        label: 'Email',
                        hint: 'nama@kampus.ac.id',
                        ikon: Icons.email,
                      ),
                      validator: validasiEmail,
                    ),
                    const SizedBox(height: 16),

                    // 4. SEMESTER: tombol "selesai" langsung menjalankan Simpan.
                    TextFormField(
                      controller: _semC,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      decoration: dekorasi(
                        label: 'Semester',
                        hint: '1 sampai 14',
                        ikon: Icons.school,
                      ),
                      validator: validasiSemester,
                      onFieldSubmitted: (_) => _simpan(),
                    ),
                    const SizedBox(height: 24),

                    FilledButton.icon(
                      onPressed: _simpan,
                      style: FilledButton.styleFrom(
                        backgroundColor: warnaUtama,
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.save),
                      label: const Text('Simpan'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _kosongkan,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: warnaUtama,
                        minimumSize: const Size.fromHeight(52),
                        side: const BorderSide(color: warnaUtama),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Kosongkan'),
                    ),
                  ],
                ),
              ),
            ),

            // Kotak Pratinjau: hanya tampil kalau data sudah valid.
            if (_hasil != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: warnaTerang, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: warnaUtama),
                        SizedBox(width: 8),
                        Text(
                          'Pratinjau data valid',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    BarisInfo(label: 'Nama', nilai: _hasil!['nama']!),
                    BarisInfo(label: 'NIM', nilai: _hasil!['nim']!),
                    BarisInfo(label: 'Email', nilai: _hasil!['email']!),
                    BarisInfo(label: 'Semester', nilai: _hasil!['semester']!),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HALAMAN 3: DETAIL MAHASISWA
// ---------------------------------------------------------------------------
class DetailMahasiswaPage extends StatelessWidget {
  const DetailMahasiswaPage({super.key, required this.mahasiswa});

  final Map<String, String> mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: warnaLatar,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BannerGradasi(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Text(
                      (mahasiswa['nama'] ?? '?')[0],
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: warnaUtama,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    mahasiswa['nama'] ?? '-',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'NIM ${mahasiswa['nim'] ?? '-'}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            KartuPutih(
              child: Column(
                children: [
                  BarisInfo(label: 'Nama', nilai: mahasiswa['nama'] ?? '-'),
                  BarisInfo(label: 'NIM', nilai: mahasiswa['nim'] ?? '-'),
                  BarisInfo(
                    label: 'Program Studi',
                    nilai: mahasiswa['prodi'] ?? '-',
                  ),
                  BarisInfo(
                    label: 'Semester',
                    nilai: mahasiswa['semester'] ?? '-',
                  ),
                  BarisInfo(label: 'Email', nilai: mahasiswa['email'] ?? '-'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: warnaUtama,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const Map<String, String> profil = {
    'Nama': 'Amelia Agustina',
    'NIM': '701240083',
    'Program Studi': 'Sistem Informasi',
    'Semester': '5',
    'Email': 'amel@uinjambi.ac.id', 
  };

  static const List<String> keahlian = ['Flutter', 'Basis Data', 'Desain UI'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: warnaLatar,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BannerGradasi(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 44, color: warnaUtama),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profil['Nama']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${profil['NIM']} · ${profil['Program Studi']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Identitas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            KartuPutih(
              child: Column(
                children: [
                  for (final d in profil.entries)
                    BarisInfo(label: d.key, nilai: d.value),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Keahlian',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final i in keahlian)
                  Chip(
                    avatar: const Icon(
                      Icons.check_circle,
                      color: warnaUtama,
                      size: 18,
                    ),
                    label: Text(i),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: warnaGaris),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET PEMBANTU: satu baris "Label : Nilai"
// ---------------------------------------------------------------------------
class BarisInfo extends StatelessWidget {
  const BarisInfo({super.key, required this.label, required this.nilai});

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(': '),
          Expanded(child: Text(nilai)),
        ],
      ),
    );
  }
}
