import 'package:flutter/material.dart';
import 'package:flutter_ces/models/producto.dart';
import 'package:flutter_ces/services/producto_service.dart';
import 'package:flutter_ces/pages/account/account_page.dart';
import 'package:flutter_ces/pages/carrito_forms/carrito_page.dart';
import 'package:flutter_ces/pages/home_forms/compra_page.dart';
import 'package:flutter_ces/pages/login_forms/login_page.dart';
import 'package:flutter_ces/widgets/bottom_navigation.dart';
import '../../components/stack_pages_route.dart';
import 'package:flutter_ces/styles/styles_home.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({super.key});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Producto> _productos = [];
  List<Producto> _filteredProductos = [];
  bool _showAccountPage = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductos();
  }

  Future<void> _loadProductos() async {
    try {
      final productos = await ProductoService.loadProductos();
      setState(() {
        _productos = productos;
        _filteredProductos = productos;
        _isLoading = false;
      });
      _precacheImages(productos);
    } catch (e) {
      debugPrint('Error cargando productos: $e');
      setState(() => _isLoading = false);
    }
  }

  void _precacheImages(List<Producto> productos) {
    for (final producto in productos) {
      precacheImage(AssetImage(producto.imagen), context);
    }
  }

  void _filterProductos(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProductos = _productos;
      } else {
        _filteredProductos = _productos.where((producto) {
          final queryLower = query.toLowerCase();
          return producto.nombre.toLowerCase().contains(queryLower) ||
              producto.info.toLowerCase().contains(queryLower);
        }).toList();
      }
    });
  }

  void _toggleAccountPage() {
    setState(() {
      _showAccountPage = !_showAccountPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: Icon(Icons.menu),
          color: HomeStyles.appBarLeadingIconColor,
        ),
        toolbarHeight: 100,
        centerTitle: true,
        title: HomeStyles.appBarTitleImage,
        backgroundColor: HomeStyles.appBarBackgroundColor,
        actions: [],
        elevation: HomeStyles.appBarElevation,
      ),
      body: Stack(
        children: [
          Visibility(
            visible: !_showAccountPage,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProductos.isEmpty
                    ? const Center(child: Text('No se encontraron productos'))
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ProductosList(
                          productos: _filteredProductos,
                          onProductoTap: _navigateToCompraPage,
                        ),
                      ),
          ),
          Visibility(
            visible: _showAccountPage,
            child: AccountPage(onClose: _toggleAccountPage),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      bottomNavigationBar: Bottom(
        onSearchChanged: _filterProductos,
        onAccountPressed: _toggleAccountPage,
        onCartPressed: () => Navigator.push(
          context,
          StackPagesRoute(
            previousPages: [ProductosPage()],
            enterPage: CarritoPage(),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  void _navigateToCompraPage(Producto producto) {
    Navigator.push(
      context,
      StackPagesRoute(
        previousPages: [ProductosPage()],
        enterPage: CompraPage(producto: producto),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.push(
      context,
      StackPagesRoute(
        previousPages: [ProductosPage()],
        enterPage: LoginPage(),
      ),
    );
  }
}

class ProductosList extends StatelessWidget {
  final List<Producto> productos;
  final Function(Producto) onProductoTap;

  const ProductosList({
    Key? key,
    required this.productos,
    required this.onProductoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) =>
            _buildProductoItem(context, productos[index]),
      ),
    );
  }

  Widget _buildProductoItem(BuildContext context, Producto producto) {
    return GestureDetector(
      key: Key('producto_card_${producto.index}'),
      onTap: () => onProductoTap(producto),
      child: Container(
        decoration: HomeStyles.productoDecoration,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'producto-${producto.index}',
                child: Image.asset(
                  producto.imagen,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              producto.nombre,
              style: HomeStyles.nombreTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              producto.info,
              style: HomeStyles.infoTextStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${producto.precio}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xff142047),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

