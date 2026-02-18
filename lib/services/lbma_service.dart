import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gold_price.dart';

class LbmaService {
  static const String _amUrl = 'https://prices.lbma.org.uk/json/gold_am.json';
  static const String _pmUrl = 'https://prices.lbma.org.uk/json/gold_pm.json';

  List<GoldPrice>? _cachedAm;
  List<GoldPrice>? _cachedPm;

  Future<void> _ensureLoaded() async {
    if (_cachedAm != null && _cachedPm != null) return;
    final results = await Future.wait([
      http.get(Uri.parse(_amUrl)),
      http.get(Uri.parse(_pmUrl)),
    ]);
    if (results[0].statusCode == 200) {
      final List<dynamic> j = json.decode(results[0].body);
      _cachedAm = j.map((e) => GoldPrice.fromJson(e)).toList();
    } else {
      throw Exception('Ошибка загрузки AM: ${results[0].statusCode}');
    }
    if (results[1].statusCode == 200) {
      final List<dynamic> j = json.decode(results[1].body);
      _cachedPm = j.map((e) => GoldPrice.fromJson(e)).toList();
    } else {
      throw Exception('Ошибка загрузки PM: ${results[1].statusCode}');
    }
  }

  Future<GoldDayData?> getByDate(String dateStr) async {
    await _ensureLoaded();
    final am = _cachedAm?.where((e) => e.date == dateStr).firstOrNull;
    final pm = _cachedPm?.where((e) => e.date == dateStr).firstOrNull;
    if (am == null && pm == null) return null;
    return GoldDayData(date: dateStr, am: am, pm: pm);
  }

  Future<List<GoldDayData>> getByRange(String from, String to) async {
    await _ensureLoaded();
    final Map<String, GoldDayData> map = {};
    for (final i in _cachedAm ?? <GoldPrice>[]) {
      if (i.date.compareTo(from) >= 0 && i.date.compareTo(to) <= 0) {
        map[i.date] = GoldDayData(date: i.date, am: i, pm: null);
      }
    }
    for (final i in _cachedPm ?? <GoldPrice>[]) {
      if (i.date.compareTo(from) >= 0 && i.date.compareTo(to) <= 0) {
        if (map.containsKey(i.date)) {
          map[i.date] = GoldDayData(date: i.date, am: map[i.date]!.am, pm: i);
        } else {
          map[i.date] = GoldDayData(date: i.date, am: null, pm: i);
        }
      }
    }
    final list = map.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }
}
