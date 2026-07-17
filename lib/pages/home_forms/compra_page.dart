import 'package:flutter/material.dart';
import 'package:flutter_ces/components/stack_pages_route.dart';
import 'package:flutter_ces/providers/carrito_provider.dart';
import 'package:flutter_ces/pages/compra_forms/compra_form_summary.dart';
import 'package:flutter_ces/models/producto.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../styles/styles_home.dart';

class CompraPage extends StatelessWidget {
  final Producto producto;

  const CompraPage({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return _ProductPageTemplate(producto: producto);
  }
}

class _ProductPageTemplate extends StatelessWidget {
  final Producto producto;

  const _ProductPageTemplate({required this.producto});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _handleBack(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: HomeStyles.appBarIconColor,
        ),
        toolbarHeight: 100,
        centerTitle: true,
        title: Image.asset(
          'assets/ces_logo.png',
          width: width / HomeStyles.appBarTitleWidthFraction,
        ),
        backgroundColor: HomeStyles.pageAppBarBackgroundColor,
        actions: const [],
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(HomeStyles.borderRadius),
            topRight: Radius.circular(HomeStyles.borderRadius),
          ),
          color: HomeStyles.bodyBackgroundColor,
        ),
        child: _ProductContent(producto: producto),
      ),
    );
  }
}

class _ProductContent extends StatelessWidget {
  final Producto producto;

  const _ProductContent({required this.producto});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Imagen del producto
          SizedBox(
            width: width * 0.70,
            height: height * 0.30,
            child: Image.asset(producto.imagen),
          ),

          // Precio del producto
          Text(
            '\$${producto.precio}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff142047),
            ),
          ),

          // Características del producto
          _ProductFeatures(features: producto.features),

          // Botones de compra
          _PurchaseButtons(producto: producto),
        ],
      ),
    );
  }
}

class _ProductFeatures extends StatelessWidget {
  final List<Map<String, String>>? features;

  const _ProductFeatures({this.features});

  @override
  Widget build(BuildContext context) {
    if (features == null || features!.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: features!.asMap().entries.map((entry) {
          final isLast = entry.key == features!.length - 1;
          return Row(
            children: [
              _FeatureCard(feature: entry.value),
              if (!isLast) const SizedBox(width: HomeStyles.buttonSpacing),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final Map<String, String> feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: HomeStyles.width,
      height: HomeStyles.height,
      decoration: BoxDecoration(
        color: HomeStyles.backgroundColorBoton,
        borderRadius: BorderRadius.circular(HomeStyles.borderRadiusBoton),
        boxShadow: const [
          BoxShadow(
            color: HomeStyles.shadowColor,
            offset: Offset(HomeStyles.shadowOffsetX, HomeStyles.shadowOffsetY),
            spreadRadius: HomeStyles.shadowSpreadRadius,
            blurRadius: HomeStyles.shadowBlurRadius,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              feature['label'] ?? '',
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              feature['value'] ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PurchaseButtons extends StatelessWidget {
  final Producto producto;

  const _PurchaseButtons({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: HomeStyles.containerHeight,
      decoration: BoxDecoration(
        color: const Color(0xff142047).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(HomeStyles.containerBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Provider.of<CarritoProvider>(context, listen: false)
                    .agregarProducto(producto);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Producto agregado correctamente'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff142047),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(HomeStyles.containerBorderRadius),
                    bottomLeft: Radius.circular(HomeStyles.containerBorderRadius),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              label: const Text('Agregar', style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _showPurchaseOptions(context, producto),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff142047),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(HomeStyles.containerBorderRadius),
                    bottomRight: Radius.circular(HomeStyles.containerBorderRadius),
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              icon: const Icon(Icons.attach_money, color: Colors.white),
              label: const Text('Comprar', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

// Funciones de utilidad
void _handleBack(BuildContext context) {
  Navigator.of(context).pop();
}

void _showPurchaseOptions(BuildContext context, Producto producto) {
  showBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          ListTile(
            title: const Text('Google Play'),
            leading: const FaIcon(FontAwesomeIcons.googlePay),
            trailing: const FaIcon(FontAwesomeIcons.moneyBill),
            onTap: () => _navigateToSummary(context, [producto]),
          ),
          ListTile(
            title: const Text('Apple Play'),
            leading: const FaIcon(FontAwesomeIcons.applePay),
            trailing: const FaIcon(FontAwesomeIcons.moneyBill),
            onTap: () => _navigateToSummary(context, [producto]),
          ),
          ListTile(
            title: const Text('Paypal'),
            leading: const FaIcon(FontAwesomeIcons.paypal),
            trailing: const FaIcon(FontAwesomeIcons.moneyBill),
            onTap: () => _navigateToSummary(context, [producto]),
          ),
        ],
      );
    },
  );
}

void _navigateToSummary(BuildContext context, List<Producto> productos) {
  Navigator.push(
    context,
    StackPagesRoute(
      previousPages: [CompraPage(producto: productos.first)],
      enterPage: const CompraFormSummary(),
    ),
  );
}
