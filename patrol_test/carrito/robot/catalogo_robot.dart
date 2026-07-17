import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class CatalogoRobot {
  final PatrolIntegrationTester $;

  CatalogoRobot(this.$);

  Future<void> verificarCatalogoVisible() async {
    // shopping_cart_outlined es el ícono del botón de carrito en bottom_navigation
    await $(find.byIcon(Icons.shopping_cart_outlined)).waitUntilVisible();
  }

  Future<void> abrirMenuLateral() async {
    await $(find.byIcon(Icons.menu)).tap();
    await $.pumpAndSettle();
  }

  Future<void> presionarLogout() async {
    await abrirMenuLateral();
    await $(find.text('Logout')).tap();
    await $.pumpAndSettle();
  }

  Future<void> irAlCarrito() async {
    // En bottom_navigation.dart: Icons.shopping_cart_outlined
    await $(find.byIcon(Icons.shopping_cart_outlined)).tap();
    await $.pumpAndSettle();
  }

  Future<void> irAlPerfil() async {
    // En bottom_navigation.dart: Icons.account_circle_outlined
    await $(find.byIcon(Icons.account_circle_outlined)).tap();
    await $.pumpAndSettle();
  }

  Future<void> abrirProducto() async {
    await $(const ValueKey('producto_card_3')).tap();
    await $.pumpAndSettle();
  }
}
