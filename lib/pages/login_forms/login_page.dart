import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ces/services/auth_service.dart';
import 'package:flutter_ces/pages/login_forms/signup_page.dart';
import 'package:flutter_ces/pages/login_forms/splash.dart';

import '../../components/stack_pages_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [Fondo(), Contenido()],
      ),
    );
  }
}

class Contenido extends StatelessWidget {
  const Contenido({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Iniciar sesión',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bienvenid@ a tu cuenta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Datos(),
        ],
      ),
    );
  }
}

class Datos extends StatefulWidget {
  const Datos({Key? key}) : super(key: key);

  @override
  State<Datos> createState() => _DatosState();
}

class _DatosState extends State<Datos> {
  bool obs = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _iniciarSesion() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    final success = await AuthService.login(email, password);

    if (!mounted) return;
    if (success) {
      Navigator.push(
        context,
        StackPagesRoute(previousPages: [const LoginPage()], enterPage: const SplashPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error de inicio de sesión'),
          content:
              const Text('El correo electrónico o la contraseña son incorrectos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email',
              style: TextStyle(
                color: Color(0xFF333333),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              )),
          const SizedBox(height: 5),
          TextFormField(
            key: const ValueKey('email_field'),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xff142047), width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Contraseña',
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            key: const ValueKey('password_field'),
            obscureText: obs,
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xff142047), width: 2),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined),
                onPressed: () => setState(() => obs = !obs),
              ),
            ),
          ),
          const Remember(),
          const SizedBox(height: 30),
          Botones(signInCallback: _iniciarSesion),
        ],
      ),
    );
  }
}

class Remember extends StatefulWidget {
  const Remember({super.key});

  @override
  State<Remember> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  bool valor = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: valor, onChanged: (value) => setState(() => valor = !valor)),
        const Text('Recordarme',
            style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
        const Spacer(),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(foregroundColor: const Color(0xff142047)),
          child: const Text('Olvidaste tu contraseña?'),
        ),
      ],
    );
  }
}

class Botones extends StatelessWidget {
  final void Function() signInCallback;

  const Botones({Key? key, required this.signInCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            key: const ValueKey('login_button'),
            onPressed: signInCallback,
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(const Color(0xff142047)),
            ),
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'O inicia con:',
          style: TextStyle(color: Color(0xFF555555), fontSize: 14),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(14),
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              child: const FaIcon(FontAwesomeIcons.google,
                  color: Color(0xffDB4437), size: 26),
            ),
            const SizedBox(width: 20),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(14),
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              child: const FaIcon(FontAwesomeIcons.facebook,
                  color: Color(0xff1877F2), size: 26),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              StackPagesRoute(
                previousPages: [const LoginPage()],
                enterPage: const SignupPage(),
              ),
            );
          },
          style: TextButton.styleFrom(foregroundColor: const Color(0xff142047)),
          child: const Text('¿Necesitás registrarte?'),
        ),
      ],
    );
  }
}

class Fondo extends StatelessWidget {
  const Fondo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF42A5F5),
          Color(0xFF1565C0),
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      )),
    );
  }
}
