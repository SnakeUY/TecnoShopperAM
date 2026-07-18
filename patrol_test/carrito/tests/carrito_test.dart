import 'package:flutter_ces/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../../login/robot/login_robot.dart';
import '../../login/data/test_credentials.dart';
import '../../login/task/setup_task.dart';
import '../robot/catalogo_robot.dart';
import '../robot/detalle_producto_robot.dart';
import '../robot/carrito_robot.dart';
import '../robot/checkout_info_robot.dart';
import '../robot/pago_robot.dart';
import '../robot/pedido_exitoso_robot.dart';
import '../data/carrito_data.dart';

void main() {
  patrolTest(
    'TC-07 - Crear un carrito de compra y concretarlo',
    tags: ['smoke', 'carrito'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login        = LoginRobot($);
      final catalogo     = CatalogoRobot($);
      final detalle      = DetalleProductoRobot($);
      final carrito      = CarritoRobot($);
      final checkoutInfo = CheckoutInfoRobot($);
      final pago         = PagoRobot($);
      final pedido       = PedidoExitosoRobot($);

      // ── Precondición ──────────────────────────────────────────
      await login.verificarLoginVisible();
      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();

      // Verificación: login exitoso
      await login.verificarInicioDeSesionExitoso();
      await catalogo.verificarCatalogoVisible();

      // ── Agregar producto ──────────────────────────────────────
      await catalogo.abrirProducto();
      await detalle.presionarAgregar();

      // Verificación: mensaje de producto agregado visible
      await detalle.verificarProductoAgregado();
      await detalle.volverAlCatalogo();

      // Verificación: volvió al catálogo
      await catalogo.verificarCatalogoVisible();

      // ── Carrito ───────────────────────────────────────────────
      await catalogo.irAlCarrito();

      // Verificación: carrito tiene al menos un producto
      await carrito.verificarBotonFinalizarVisible();
      await carrito.verificarTotalMayorACero();

      await carrito.presionarFinalizarCompra();

      // ── Checkout ─────────────────────────────────────────────
      await checkoutInfo.presionarSiguienteEnResumen();
      await checkoutInfo.completarFormulario(
        email:        CarritoData.email,
        apellido:     CarritoData.apellido,
        direccion:    CarritoData.direccion,
        ciudad:       CarritoData.ciudad,
        codigoPostal: CarritoData.codigoPostal,
      );
      await checkoutInfo.presionarContinuarAlPago();

      // ── Pago ─────────────────────────────────────────────────
      await pago.completarFormulario(
        numero: CarritoData.numeroTarjeta,
        nombre: CarritoData.nombreTarjeta,
        fecha:  CarritoData.fechaExpiracion,
        cvv:    CarritoData.cvv,
      );
      await pago.presionarComprar();

      // Verificación final: pedido procesado exitosamente
      await pedido.verificarPedidoExitoso();
    },
  );

  patrolTest(
    'TC-08 - Crear un carrito de compra y cancelarlo',
    tags: ['regression', 'carrito'],
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);
      final detalle  = DetalleProductoRobot($);
      final carrito  = CarritoRobot($);

      // ── Precondición ──────────────────────────────────────────
      await login.verificarLoginVisible();
      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      // ── Agregar producto ──────────────────────────────────────
      await catalogo.abrirProducto();
      await detalle.presionarAgregar();
      await detalle.verificarProductoAgregado();
      await detalle.volverAlCatalogo();

      // ── Carrito ───────────────────────────────────────────────
      await catalogo.irAlCarrito();

      // Verificación: producto presente en el carrito
      await carrito.verificarBotonFinalizarVisible();
      await carrito.verificarTotalMayorACero();

      // Eliminar producto
      await carrito.eliminarPrimerProducto();

      // Verificación: carrito vacío
      await carrito.verificarCarritoVacio();

      // Verificación: botón Finalizar Compra deshabilitado
      

      // Volver al catálogo
      await carrito.volverAlCatalogo();

      // Verificación: volvió al catálogo
      await catalogo.verificarCatalogoVisible();

      await catalogo.presionarLogout();
      await login.verificarLoginVisible();
    },
  );
}
