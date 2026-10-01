import 'dart:convert';
import 'package:flutter/services.dart';
import '../constants/app_assets.dart';
import '../models/azkar_item.dart';

class AzkarRepository {
  AzkarRepository._();

  static Map<String, dynamic>? _root;

  static Future<Map<String, dynamic>> _loadRoot() async {
    final cached = _root;
    if (cached != null) return cached;
    final raw = await rootBundle.loadString(AppAssets.azkar);
    _root = jsonDecode(raw.replaceFirst('\ufeff', '')) as Map<String, dynamic>;
    return _root!;
  }

  static Future<List<String>> categories() async {
    final root = await _loadRoot();
    return root.keys.toList(growable: false);
  }

  static Future<List<AzkarItem>> loadCategory(String category) async {
    final root = await _loadRoot();
    final items = <AzkarItem>[];

    void collect(dynamic node) {
      if (node is List) {
        for (final child in node) {
          collect(child);
        }
      } else if (node is Map) {
        final map = Map<String, dynamic>.from(node);
        if (map.containsKey('content')) {
          items.add(AzkarItem.fromJson(map));
        } else {
          for (final value in map.values) {
            collect(value);
          }
        }
      }
    }

    collect(root[category]);
    return items;
  }
}
