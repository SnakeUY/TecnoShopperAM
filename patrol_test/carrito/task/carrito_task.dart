import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../robot/catalogo_robot.dart';
import '../robot/detalle_producto_robot.dart';
import '../robot/carrito_robot.dart';
import '../robot/checkout_info_robot.dart';
import '../robot/pago_robot.dart';
import '../data/carrito_data.dart';

class CarritoTask {
  final PatrolTester $;
  final _catalogo     = CatalogoRobot();
  final _detalle      = DetalleProductoRobot();
  final _carrito      = CarritoRobot();
  final _checkoutInfo = CheckoutInfoRobot();
  final _pago         = PagoRobot();

  CarritoTask(this.$);

  // ── Catálogo ───────────────────────────────────────────────────

  Future<void> agregarProducto() async {
    await $(_catalogo.tarjetaProducto).tap();
    await $.pumpAndSettle();
    await $(_detalle.botonAgregar).tap();
    await $.pumpAndSettle();
    await $(_detalle.botonAtras).tap();
    await $.pumpAndSettle();
  }

  Future<void> irAlCarrito() async {
    await $(_catalogo.botonCarrito).tap();
    await $.pumpAndSettle();
  }

  Future<void> irAlPerfil() async {
    await $(_catalogo.botonPerfil).tap();
    await $.pumpAndSettle();
  }

  // ── Carrito ────────────────────────────────────────────────────

  Future<void> eliminarProducto(Finder cardFinder) async {
    await $(_carrito.botonBorrar(cardFinder)).tap();
    await $.pumpAndSettle();
  }

  Future<void> iniciarCheckout() async {
    await $(_carrito.botonFinalizarCompra).tap();
    await $.pumpAndSettle();
  }

  // ── Checkout - Información ─────────────────────────────────────

  Future<void> completarInformacionEnvio() async {
    await $(_checkoutInfo.campoEmail).enterText(CarritoData.email);
    await $.pumpAndSettle();

    await $(_checkoutInfo.dropdownPais).tap();
    await $.pumpAndSettle();
    await $(_checkoutInfo.selectorUruguay).tap();
    await $.pumpAndSettle();

    await $(_checkoutInfo.campoNombre).enterText(CarritoData.nombre);
    await $(_checkoutInfo.campoApellido).enterText(CarritoData.apellido);
    await $(_checkoutInfo.campoDireccion).enterText(CarritoData.direccion);
    await $(_checkoutInfo.campoApartamento).enterText(CarritoData.apartamento);
    await $(_checkoutInfo.campoCiudad).enterText(CarritoData.ciudad);
    await $(_checkoutInfo.campoCodigoPostal).enterText(CarritoData.codigoPostal);
    await $(_checkoutInfo.campoCelular).enterText(CarritoData.celular);
    await $.pumpAndSettle();

    await $(_checkoutInfo.botonContinuarAlPago).tap();
    await $.pumpAndSettle();
  }

  // ── Checkout - Pago ────────────────────────────────────────────

  Future<void> completarPago() async {
    await $(_pago.campoNumeroTarjeta).enterText(CarritoData.numeroTarjeta);
    await $(_pago.campoNombreTarjeta).enterText(CarritoData.nombreTarjeta);
    await $(_pago.campoFechaExpiracion).enterText(CarritoData.fechaExpiracion);
    await $(_pago.campoCvv).enterText(CarritoData.cvv);
    await $.pumpAndSettle();

    await $(_pago.botonComprar).tap();
    await $.pumpAndSettle();
  }
}
