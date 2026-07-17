# TecnoShopper

Aplicación Flutter de e-commerce para productos electrónicos y tecnología.

## Características

- **Catálogo de productos**: más de 30 ítems (laptops, consolas, accesorios, componentes y periféricos)
- **Carrito de compras**: agregar, eliminar y gestionar productos con estado vía Provider
- **Autenticación**: registro e inicio de sesión con persistencia local en JSON
- **Checkout completo**: flujo en pasos (datos → pago → resumen → confirmación)
- **Tests de integración**: automatización con Patrol y patrón Robot
- **Multiplataforma**: Android, iOS, Web, Windows, macOS y Linux

## Requisitos

- Flutter SDK >= 3.4.0
- Dart SDK >= 3.4.0

## Estructura del Proyecto

```
lib/
├── components/          # Widgets reutilizables (SubmitButton, SectionTitle, etc.)
├── core/theme/          # AppColors y AppTheme (Material 3)
├── form_inputs/         # Campos de formulario con validación
├── models/              # Producto, Usuario
├── pages/
│   ├── login_forms/     # LoginPage, SignupPage, Splash
│   ├── home_forms/      # ProductosPage, CompraPage
│   ├── carrito_forms/   # CarritoPage
│   ├── compra_forms/    # Flujo de checkout
│   └── helpers/         # FormMixin, estilos, datos de demo
├── providers/           # CarritoProvider (ChangeNotifier)
├── services/            # AuthService, ProductoService, StorageService
└── main.dart

patrol_test/
└── login/
    ├── robot/           # Robots del patrón Robot
    └── tests/           # Casos de test

assets/
├── productos.json       # Catálogo de productos
├── seed_users.json      # Usuarios de prueba iniciales
└── products/            # Imágenes de productos
```

## Dependencias

| Paquete | Propósito |
|---|---|
| `provider` | Gestión de estado del carrito |
| `flutter_masked_text2` | Máscaras de entrada de texto |
| `path_provider` / `shared_preferences` | Almacenamiento local |
| `patrol` | Testing de integración |
| `parameterized_test` | Tests parametrizados |
| `csv` | Manejo de archivos CSV en tests |
| `flutter_svg` | Renderizado de SVGs |
| `font_awesome_flutter` | Iconos Font Awesome |

## Instalación y Ejecución

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en modo desarrollo
flutter run

# Ejecutar en modo release
flutter run --release
```

## Tests

```bash
# Tests de integración (requiere dispositivo o emulador conectado)
patrol test

# Test específico
patrol test --target patrol_test/login/tests/login_test.dart
```

Los tests siguen el **patrón Robot**. Ver [AGENTS.md](AGENTS.md) para la guía completa.

## Allure Reports

El proyecto genera reportes visuales con Allure al ejecutar los tests en Android.

Ver la guía de instalación, ejecución y configuración en [ALLURE_SETUP.md](ALLURE_SETUP.md).

## Build para Producción

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Google Play)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release
```

## Licencia

Proyecto privado — TecnoShopper
