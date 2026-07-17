class Usuario {
  final String email;
  final String password;
  String nombre;
  String apellido;
  String telefono;

  Usuario({
    required this.email,
    required this.password,
    this.nombre = '',
    this.apellido = '',
    this.telefono = '',
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      telefono: json['telefono'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
    };
  }
}
