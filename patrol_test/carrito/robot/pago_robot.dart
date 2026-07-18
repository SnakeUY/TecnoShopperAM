import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class PagoRobot {
  final PatrolIntegrationTester $;

  PagoRobot(this.$);

  Finder _campo(String key) => find.descendant(
        of: find.byKey(ValueKey(key)),
        matching: find.byType(TextFormField),
      );

  Future<void> _escribirAcumulando(Finder campo, String texto) async {
    await $(campo).tap();
    await $.tester.pump(const Duration(milliseconds: 200));

    String acumulado = '';
    for (final char in texto.split('')) {
      acumulado += char;
      await $.tester.enterText(campo, acumulado);
      await $.tester.pump(const Duration(milliseconds: 100));
    }
    await $.pumpAndSettle();
  }

  Future<void> _cerrarTeclado() async {
    await $.tester.testTextInput.receiveAction(TextInputAction.done);
    await $.tester.pump(const Duration(milliseconds: 300));
  }

  Future<void> completarFormulario({
    required String numero,
    required String nombre,
    required String fecha,
    required String cvv,
  }) async {
    // Número de tarjeta — tiene formatter, escribir acumulando
    await $(_campo('ccNumero')).waitUntilVisible();
    await _escribirAcumulando(_campo('ccNumero'), numero);
    await _cerrarTeclado(); // ← cerrar teclado antes del siguiente campo

    // Nombre en tarjeta
    await $(_campo('ccNombre')).waitUntilVisible();
    await $(_campo('ccNombre')).enterText(nombre);
    await _cerrarTeclado();

    // Fecha de expiración — tiene formatter
    await $(_campo('ccExpFecha')).waitUntilVisible();
    await _escribirAcumulando(_campo('ccExpFecha'), fecha);
    await _cerrarTeclado();

    // CVV — tiene formatter
    await $(_campo('ccCodigo')).waitUntilVisible();
    await _escribirAcumulando(_campo('ccCodigo'), cvv);

    // Cerrar teclado y hacer scroll hasta el botón Comprar
    await _cerrarTeclado();
    await $.tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -300),
    );
    await $.tester.pump(const Duration(milliseconds: 300));
  }

  Future<void> presionarComprar() async {
    await $(find.text('Comprar')).waitUntilVisible();
    await $(find.text('Comprar')).tap();
    await $.tester.pump(const Duration(seconds: 3));
  }
}
