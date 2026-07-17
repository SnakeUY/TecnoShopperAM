import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_ces/models/producto.dart';

class ProductoService {
  static List<Producto>? _cache;

  static Future<List<Producto>> loadProductos() async {
    if (_cache != null) return _cache!;
    final String data = await rootBundle.loadString('assets/productos.json');
    final jsonList = json.decode(data) as List<dynamic>;
    _cache = jsonList.map((json) => Producto.fromJson(json)).toList();
    return _cache!;
  }
}
