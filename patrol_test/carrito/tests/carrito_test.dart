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
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login        = LoginRobot($);
      final catalogo     = CatalogoRobot($);
      final detalle      = DetalleProductoRobot($);
      final carrito      = CarritoRobot($);
      final checkoutInfo = CheckoutInfoRobot($);
      final pago         = PagoRobot($);
      final pedido       = PedidoExitosoRobot($);

      // Si no hay usuario registrado, registrar uno ahora
      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      await catalogo.abrirProducto();
      await detalle.presionarAgregar();
      await detalle.volverAlCatalogo();

      await catalogo.irAlCarrito();
      await carrito.verificarBotonFinalizarVisible();
      await carrito.presionarFinalizarCompra();

      await checkoutInfo.presionarSiguienteEnResumen();

      await checkoutInfo.completarFormulario(
        email:        CarritoData.email,
        apellido:     CarritoData.apellido,
        direccion:    CarritoData.direccion,
        apartamento:  CarritoData.apartamento,
        ciudad:       CarritoData.ciudad,
        codigoPostal: CarritoData.codigoPostal,
        celular:      CarritoData.celular,
      );
      await checkoutInfo.presionarContinuarAlPago();

      await pago.completarFormulario(
        numero: CarritoData.numeroTarjeta,
        nombre: CarritoData.nombreTarjeta,
        fecha:  CarritoData.fechaExpiracion,
        cvv:    CarritoData.cvv,
      );
      await pago.presionarComprar();

      await pedido.verificarPedidoExitoso();
    },
  );

  patrolTest(
    'TC-08 - Crear un carrito de compra y cancelarlo',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      final login    = LoginRobot($);
      final catalogo = CatalogoRobot($);
      final detalle  = DetalleProductoRobot($);
      final carrito  = CarritoRobot($);

      await ensureUsuarioRegistrado($);

      final email    = await TestCredentials.leerEmail();
      final password = await TestCredentials.leerPassword();

      await login.ingresarEmail(email);
      await login.ingresarPassword(password);
      await login.presionarBotonLogin();
      await login.verificarInicioDeSesionExitoso();

      await catalogo.abrirProducto();
      await detalle.presionarAgregar();
      await detalle.volverAlCatalogo();

      await catalogo.irAlCarrito();
      await carrito.eliminarPrimerProducto();
      await carrito.verificarCarritoVacio();

      await carrito.volverAlCatalogo();
      await catalogo.verificarCatalogoVisible();

      await catalogo.presionarLogout();
    },
  );
}
