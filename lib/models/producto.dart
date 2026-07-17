class Producto {
  final int index;
  final String imagen;
  final String nombre;
  final String info;
  final num precio;
  final List<Map<String, String>>? features;
  int cantidad;

  Producto({
    required this.index,
    required this.imagen,
    required this.nombre,
    required this.info,
    required this.precio,
    this.features,
    this.cantidad = 1,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      index: json['index'],
      imagen: json['imagen'],
      nombre: json['nombre'],
      info: json['info'],
      precio: json['precio'],
      features: json['features'] != null
          ? (json['features'] as List<dynamic>)
              .map((f) => Map<String, String>.from(f as Map))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'imagen': imagen,
      'nombre': nombre,
      'info': info,
      'precio': precio,
      'features': features,
      'cantidad': cantidad,
    };
  }

  Producto copyWith({
    int? index,
    String? imagen,
    String? nombre,
    String? info,
    num? precio,
    List<Map<String, String>>? features,
    int? cantidad,
  }) {
    return Producto(
      index: index ?? this.index,
      imagen: imagen ?? this.imagen,
      nombre: nombre ?? this.nombre,
      info: info ?? this.info,
      precio: precio ?? this.precio,
      features: features ?? this.features,
      cantidad: cantidad ?? this.cantidad,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Producto &&
        other.index == index &&
        other.imagen == imagen &&
        other.nombre == nombre &&
        other.info == info &&
        other.precio == precio;
  }

  @override
  int get hashCode {
    return index.hashCode ^
        imagen.hashCode ^
        nombre.hashCode ^
        info.hashCode ^
        precio.hashCode;
  }
}
