import 'package:flutter/material.dart';

class LFC {
  // Liverpool FC official colors
  static const Color red = Color(0xFFC8102E);
  static const Color redDark = Color(0xFFA00D24);
  static const Color redDarker = Color(0xFF7A0A1B);
  static const Color gold = Color(0xFFF6EB61);
  static const Color goldDim = Color(0x1FF6EB61);

  // Dark UI
  static const Color bg = Color(0xFF0F0F0F);
  static const Color bg2 = Color(0xFF1A1A1A);
  static const Color card = Color(0xFF1E1E1E);
  static const Color hover = Color(0xFF2A2A2A);
  static const Color text = Color(0xFFF5F5F5);
  static const Color text2 = Color(0xFFB0B0B0);
  static const Color muted = Color(0xFF666666);
  static const Color border = Color(0xFF2A2A2A);
  static const Color green = Color(0xFF4ADE80);
  static const Color redLight = Color(0xFFF87171);

  static const List<String> currencies = ['USD', 'GBP', 'EUR'];
  static const List<String> symbols = ['\$', '£', '€'];

  static String fmtPrice(double? v, int ci) {
    if (v == null || v == 0) return '—';
    return '${symbols[ci]} ${v.toStringAsFixed(2)}';
  }

  static String fmtDate(String ds) {
    final m = ['янв','фев','мар','апр','май','июн','июл','авг','сен','окт','ноя','дек'];
    final p = ds.split('-');
    if (p.length != 3) return ds;
    return '${int.parse(p[2])} ${m[int.parse(p[1]) - 1]} ${p[0]}';
  }

  static ThemeData get theme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,
    colorScheme: const ColorScheme.dark(surface: bg, primary: red),
    dividerColor: border,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: text),
      bodySmall: TextStyle(color: text2),
    ),
  );
}
