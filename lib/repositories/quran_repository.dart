import 'package:flutter/services.dart';
import '../constants/app_assets.dart';
import '../models/surah.dart';

class QuranRepository {
  QuranRepository._();

  static List<Surah>? _catalog;

  static Future<List<Surah>> loadCatalog() async {
    final cached = _catalog;
    if (cached != null) return cached;

    final raw = await rootBundle.loadString(AppAssets.surasList);
    final lists = RegExp(
      r'List<String>\s+\w+\s*=\s*\[(.*?)\];',
      dotAll: true,
    ).allMatches(raw).toList();

    if (lists.length < 3) {
      throw const FormatException('Suras List.txt does not contain 3 lists.');
    }

    List<String> values(RegExpMatch match) {
      final body = match.group(1) ?? '';
      return RegExp('"([^"]*)"|\'([^\']*)\'')
          .allMatches(body)
          .map((m) => (m.group(1) ?? m.group(2) ?? '').trim())
          .where((value) => value.isNotEmpty)
          .toList(growable: false);
    }

    final arabic = values(lists[0]);
    final english = values(lists[1]);
    final counts = values(lists[2]);
    final length = <int>[arabic.length, english.length, counts.length]
        .reduce((a, b) => a < b ? a : b);

    _catalog = List<Surah>.generate(
      length,
      (index) => Surah(
        number: index + 1,
        arabicName: arabic[index],
        englishName: english[index],
        verseCount: int.tryParse(counts[index]) ?? 0,
      ),
      growable: false,
    );
    return _catalog!;
  }

  static Future<List<String>> loadVerses(int surahNumber) async {
    final raw = await rootBundle.loadString(AppAssets.surahFile(surahNumber));
    return raw
        .replaceAll('\ufeff', '')
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);
  }
}
