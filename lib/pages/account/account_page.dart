import 'package:flutter/material.dart';
import 'package:flutter_ces/services/auth_service.dart';

class AccountPage extends StatefulWidget {
  final VoidCallback onClose;

  const AccountPage({super.key, required this.onClose});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _dateNacController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();

  String? _currentUserEmail;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserEmail();
  }

  Future<void> _loadCurrentUserEmail() async {
    _currentUserEmail = await AuthService.getCurrentUserEmail();
    if (_currentUserEmail != null) {
      _loadUserData(_currentUserEmail!);
    }
  }

  Future<void> _loadUserData(String email) async {
    try {
      final perfil = await AuthService.getUserProfile(email);
      if (perfil != null) {
        _nombreController.text = perfil['nombre'] ?? '';
        _apellidoController.text = perfil['apellido'] ?? '';
        _dateNacController.text = perfil['fecNac'] ?? '';
        _direccionController.text = perfil['direccion'] ?? '';
        _paisController.text = perfil['pais'] ?? '';
      }
    } catch (e) {
      debugPrint('Error al cargar los datos del usuario: $e');
    }
  }

  Future<void> _saveUserProfile() async {
    try {
      await AuthService.saveUserProfile(_currentUserEmail!, {
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'fecNac': _dateNacController.text,
        'direccion': _direccionController.text,
        'pais': _paisController.text,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado correctamente')),
      );
    } catch (e) {
      debugPrint('Error al guardar el perfil del usuario: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el perfil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de Cuenta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onClose,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                    hintText: "Nombre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withValues(alpha: 0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.person)),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _apellidoController,
                decoration: InputDecoration(
                    hintText: "Apellido",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withValues(alpha: 0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.person_2)),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(
                    hintText: "Teléfono",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withValues(alpha: 0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.phone)),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _dateNacController,
                decoration: InputDecoration(
                    hintText: "Fecha de Nacimiento",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withValues(alpha: 0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_month)),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _direccionController,
                decoration: InputDecoration(
                    hintText: "Dirección",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withValues(alpha: 0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.house)),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _paisController,
                decoration: InputDecoration(
                    hintText: "País",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withValues(alpha: 0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.location_pin)),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveUserProfile,
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 40),
                    backgroundColor: const Color(0xff142047),
                  ),
                  child: const Text(
                    "Guardar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
