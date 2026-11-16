
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:amelia_form_input/main.dart';

void main() {
  
  group('validasiNama', () {
    test('kosong atau hanya spasi ditolak', () {
      expect(validasiNama(''), 'Nama wajib diisi');
      expect(validasiNama('   '), 'Nama wajib diisi');
      expect(validasiNama(null), 'Nama wajib diisi');
    });

    test('kurang dari 3 huruf ditolak', () {
      expect(validasiNama('Ab'), 'Nama minimal 3 huruf');
    });

    test('mengandung angka ditolak', () {
      expect(validasiNama('Rina123'), contains('tanpa angka'));
    });

    test('nama benar diterima', () {
      expect(validasiNama('Rina Amelia'), isNull);
    });
  });

  group('validasiNim', () {
    test('kosong ditolak', () {
      expect(validasiNim(''), 'NIM wajib diisi');
    });

    test('mengandung huruf ditolak', () {
      expect(validasiNim('2023a01'), 'NIM hanya boleh berisi angka');
    });

    test('kurang dari 7 digit ditolak', () {
      expect(validasiNim('12345'), 'NIM minimal 7 digit');
    });

    test('NIM benar diterima', () {
      expect(validasiNim('701240083'), isNull);
    });
  });

  group('validasiEmail', () {
    test('kosong ditolak', () {
      expect(validasiEmail(''), 'Email wajib diisi');
    });

    test('format salah ditolak', () {
      expect(
        validasiEmail('rina@'),
        'Format email tidak valid (contoh: nama@kampus.ac.id)',
      );
    });

    test('bukan email kampus (.ac.id) ditolak', () {
      expect(validasiEmail('rina@gmail.com'), contains('.ac.id'));
    });

    test('email kampus benar diterima', () {
      expect(validasiEmail('amelia@uinjambi.ac.id'), isNull);
    });
  });

  group('validasiSemester', () {
    test('kosong ditolak', () {
      expect(validasiSemester(''), 'Semester wajib diisi');
    });

    test('bukan angka ditolak', () {
      expect(validasiSemester('lima'), 'Semester harus berupa angka');
    });

    test('di luar rentang 1 sampai 14 ditolak', () {
      expect(validasiSemester('0'), 'Semester harus antara 1 dan 14');
      expect(validasiSemester('15'), 'Semester harus antara 1 dan 14');
    });

    test('semester benar diterima', () {
      expect(validasiSemester('5'), isNull);
      expect(validasiSemester('14'), isNull);
    });
  });

  // -------------------------------------------------------------------------
  // BAGIAN 2: Uji tampilan dan alur form
  // -------------------------------------------------------------------------
  group('Alur form Tambah Mahasiswa', () {
    // Membuka aplikasi, lalu masuk ke halaman form lewat tombol "Tambah".
    Future<void> bukaForm(WidgetTester tester) async {
      // Perbesar layar uji supaya semua tombol terlihat.
      tester.view.physicalSize = const Size(900, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Tambah'));
      await tester.pumpAndSettle();
    }

    testWidgets('Dashboard tampil dengan tombol Tambah', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('Dashboard Akademik'), findsOneWidget);
      expect(find.text('Daftar Mahasiswa'), findsOneWidget);
      expect(find.text('Tambah'), findsOneWidget);
    });

    testWidgets('Tombol Tambah membuka halaman form', (tester) async {
      await bukaForm(tester);
      expect(find.text('Tambah Mahasiswa'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
    });

    testWidgets('Simpan dengan form kosong menampilkan 4 pesan galat',
        (tester) async {
      await bukaForm(tester);

      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Nama wajib diisi'), findsOneWidget);
      expect(find.text('NIM wajib diisi'), findsOneWidget);
      expect(find.text('Email wajib diisi'), findsOneWidget);
      expect(find.text('Semester wajib diisi'), findsOneWidget);
      expect(find.text('Pratinjau data valid'), findsNothing);
    });

    testWidgets('Data valid menampilkan kotak Pratinjau', (tester) async {
      await bukaForm(tester);

      final kolom = find.byType(TextFormField);
      await tester.enterText(kolom.at(0), 'Amelia Agustina');
      await tester.enterText(kolom.at(1), '701240083');
      await tester.enterText(kolom.at(2), 'amelia@uinjambi.ac.id');
      await tester.enterText(kolom.at(3), '5');

      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Pratinjau data valid'), findsOneWidget);
      expect(find.text('Nama wajib diisi'), findsNothing);
    });

    testWidgets('Tombol Kosongkan membersihkan form dan Pratinjau',
        (tester) async {
      await bukaForm(tester);

      final kolom = find.byType(TextFormField);
      await tester.enterText(kolom.at(0), 'Amelia Agustina');
      await tester.enterText(kolom.at(1), '701240083');
      await tester.enterText(kolom.at(2), 'amelia@uinjambi.ac.id');
      await tester.enterText(kolom.at(3), '5');
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();
      expect(find.text('Pratinjau data valid'), findsOneWidget);

      await tester.tap(find.text('Kosongkan'));
      await tester.pumpAndSettle();

      expect(find.text('Pratinjau data valid'), findsNothing);
      expect(find.text('Amelia Agustina'), findsNothing);
    });
  });
}
