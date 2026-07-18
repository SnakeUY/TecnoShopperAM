import 'package:flutter/material.dart';
import 'package:flutter_ces/providers/carrito_provider.dart';
import '../helpers/demo_data.dart';
import 'package:provider/provider.dart';

import '../../components/section_separator.dart';
import '../../components/stack_pages_route.dart';
import '../../components/submit_button.dart';
import '../home_forms/demo.dart';
import '../helpers/form_page.dart';
import 'compra_form_information.dart';
import '../helpers/styles.dart';

class CompraFormSummary extends StatelessWidget {
  final double? pageSize;
  final bool isHidden;

  const CompraFormSummary({Key? key, this.pageSize, this.isHidden = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormPage(
      pageSizeProportion: pageSize ?? 0.85,
      isHidden: isHidden,
      title: 'Resumen de Pedido',
      children: <Widget>[
        _buildOrderSummary(context),
        const Separator(),
        _buildOrderInfo(context),
        const Separator(),
        _buildOrderTotal(context),
        _buildOrderSpecialInstructions(context),
        SubmitButton(
          padding: EdgeInsets.symmetric(horizontal: FormStyles.hzPadding),
          child: Text('Siguiente', style: FormStyles.submitButtonText),
          onPressed: () => _handleSubmit(context),
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context) {
    Navigator.push(
      context,
      StackPagesRoute(
        previousPages: [CompraFormSummary(pageSize: .85, isHidden: true)],
        enterPage: CompraFormInformation(),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 135,
              height: 135,
              decoration: BoxDecoration(
                border: Border.all(color: FormStyles.lightGrayColor),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffEDF1F9),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: Color(0xff142047),
              ),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: const Color(0xff142047),
                ),
                child: Center(
                  child: Text(
                    '${carrito.cantidad}',
                    style: FormStyles.imageBatch.copyWith(fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 36),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tu carrito',
              style: FormStyles.orderTotalLabel,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${carrito.total}',
              style: FormStyles.orderTotal,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Subtotal', style: FormStyles.orderLabel),
            Text('\$${carrito.total}', style: FormStyles.orderPrice),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Entrega', style: FormStyles.orderLabel),
            Text('GRATIS', style: FormStyles.orderPrice),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderTotal(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Total', style: FormStyles.orderTotalLabel),
          Text('\$${carrito.total}', style: FormStyles.orderTotal),
        ],
      ),
    );
  }

  Widget _buildOrderSpecialInstructions(BuildContext context) {
    String name = 'Informacion adicional';
    SharedFormState sharedState =
        Provider.of<SharedFormState>(context, listen: false);
    var values = sharedState.valuesByName;
    return TextFormField(
      onChanged: (value) => values[FormKeys.instructions] = value,
      initialValue: values.containsKey(FormKeys.instructions)
          ? values[FormKeys.instructions]
          : "",
      style: FormStyles.inputLabel,
      decoration: FormStyles.getInputDecoration(helper: name),
      minLines: 4,
      maxLines: 6,
    );
  }
}
