import 'package:flutter_ces/core/theme/app_theme.dart';
import 'package:flutter_ces/pages/carrito_forms/carrito_page.dart';
import 'package:flutter_ces/providers/carrito_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ces/pages/home_forms/demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarritoProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const CompraFormsDemo(),
        routes: {
          '/carrito': (context) => const CarritoPage(),
        },
      ),
    );
  }
}
