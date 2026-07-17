import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class CheckoutInfoRobot {
  final PatrolIntegrationTester $;

  CheckoutInfoRobot(this.$);

  Future<void> presionarSiguienteEnResumen() async {
    await $(find.text('Siguiente')).waitUntilVisible();
    await $(find.text('Siguiente')).tap();
    await $.pumpAndSettle();
  }

  Finder _campo(String key) => find.descendant(
        of: find.byKey(ValueKey(key)),
        matching: find.byType(TextFormField),
      );

  Future<void> completarFormulario({
    required String email,
    required String apellido,
    required String direccion,
    required String ciudad,
    required String codigoPostal,
    String apartamento = '',
    String celular = '',
  }) async {
    // FormKeys.email = "email"
    await $(_campo('email')).waitUntilVisible();
    await $(_campo('email')).enterText(email);
    await $.pumpAndSettle();

    // Scroll para exponer los campos siguientes
    await $.tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -300),
    );
    await $.pumpAndSettle();

    // FormKeys.lastName = "apellido"
    await $(_campo('apellido')).waitUntilVisible();
    await $(_campo('apellido')).enterText(apellido);
    await $.pumpAndSettle();

    // FormKeys.address = "direccion"
    await $(_campo('direccion')).waitUntilVisible();
    await $(_campo('direccion')).enterText(direccion);
    await $.pumpAndSettle();

    // FormKeys.apt = "apt"
    if (apartamento.isNotEmpty) {
      await $(_campo('apt')).waitUntilVisible();
      await $(_campo('apt')).enterText(apartamento);
      await $.pumpAndSettle();
    }

    // FormKeys.city = "ciudad"
    await $(_campo('ciudad')).waitUntilVisible();
    await $(_campo('ciudad')).enterText(ciudad);
    await $.pumpAndSettle();

    // FormKeys.postal = "postal"
    await $(_campo('postal')).waitUntilVisible();
    await $(_campo('postal')).enterText(codigoPostal);
    await $.pumpAndSettle();

    // FormKeys.phone = "celular"
    if (celular.isNotEmpty) {
      await $.tester.drag(
        find.byType(SingleChildScrollView).first,
        const Offset(0, -200),
      );
      await $.pumpAndSettle();
      await $(_campo('celular')).waitUntilVisible();
      await $(_campo('celular')).enterText(celular);
      await $.pumpAndSettle();
    }
  }

  Future<void> presionarContinuarAlPago() async {
    await $.tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -300),
    );
    await $.pumpAndSettle();
    await $(find.text('Continuar al pago')).waitUntilVisible();
    await $(find.text('Continuar al pago')).tap();
    await $.pumpAndSettle();
  }
}
