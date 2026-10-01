import 'package:flutter/services.dart';
import '../constants/app_assets.dart';
import '../models/hadith.dart';

class HadithRepository {
  HadithRepository._();

  static List<Hadith>? _cache;

  static Future<List<Hadith>> loadAll() async {
    final cached = _cache;
    if (cached != null) return cached;

    final values = await Future.wait(
      List<Future<Hadith>>.generate(50, (index) => load(index + 1)),
    );
    _cache = values;
    return values;
  }

  static Future<Hadith> load(int number) async {
    final raw = await rootBundle.loadString(AppAssets.hadithFile(number));
    final lines = raw
        .replaceAll('\ufeff', '')
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    final title = lines.isEmpty ? 'الحديث $number' : lines.first;
    final body = lines.length <= 1 ? '' : lines.skip(1).join('\n');
    return Hadith(number: number, title: title, body: body);
  }
}
